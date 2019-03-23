#!/bin/bash

_requires_token() {
	if [[ -z ${GITHUB_TOKEN:-} ]]; then
		echo "Set the GITHUB_TOKEN env variable."
		exit 1
	fi
}

_has_token() {
	[[ -n ${GITHUB_TOKEN:-} ]]
}

_should_fix_issue() {
	pr_url="$(jq --raw-output '.issue.pull_request.url | select(. != null)' "$GITHUB_EVENT_PATH")"
	fix_comment="$(jq --raw-output ".comment.body | select(. | startswith(\"$1\"))" "$GITHUB_EVENT_PATH")"
	[[ -n $pr_url ]] && [[ -n $fix_comment ]] || exit 0
}

__switch_to_branch() {
	# TODO: Not working yet
	remote_branch_name=$(git name-rev --name-only "${GITHUB_SHA}")
	git checkout -b "${remote_branch_name#remotes/origin}" --track "$remote_branch_name"
}

_should_fix_review() {
	fix_comment="$(jq --raw-output ".review.body | select(. | startswith(\"$1\"))" "$GITHUB_EVENT_PATH")"
	[[ -n $fix_comment ]] || exit 0
}

_git_is_dirty() {
	[[ -n "$(git status -s)" ]]
}

_local_commit() {
	git config --global user.name "github-actions[bot]"
	git config --global user.email "github-actions[bot]@users.noreply.github.com"
	git add .
	git commit -m "${GITHUB_ACTION}: lint fix"
}

_remote_commit() {
	tmp_file="$(mktemp)"

	# shellcheck disable=SC2034  # Unused variables left for readability
	while read -r _src_mode dst_mode _src_sha dst_sha flag path; do
		file_payload="{\"encoding\": \"base64\", \"content\": \"$(base64 "$path" | tr -d '\n')\"}"
		file_response=$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
			-d "$file_payload" \
			"https://api.github.com/repos/${GITHUB_REPOSITORY}/git/blobs")
		echo "{ \"mode\": \"${dst_mode}\", \"path\": \"${path}\", \"sha\": $(jq '.sha' <<<"$file_response")}" >>"$tmp_file"
	done < <(git diff-files)

	head_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
		-X GET \
		"https://api.github.com/repos/${GITHUB_REPOSITORY}/git/${GITHUB_REF}")"
	head_sha="$(jq '.object.sha' <<<"$head_response")"

	tree_payload="{\"base_tree\": ${head_sha}, \"tree\": $(jq -s '.' "$tmp_file")}"
	tree_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
		-d "$tree_payload" \
		"https://api.github.com/repos/${GITHUB_REPOSITORY}/git/trees")"

	commit_payload="{\"message\": \"${GITHUB_ACTION}: lint fix\", \"tree\": $(jq '.sha' <<<"$tree_response"), \"parents\": [${head_sha}]}"
	commit_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
		-d "$commit_payload" \
		"https://api.github.com/repos/${GITHUB_REPOSITORY}/git/commits")"

	update_branch_payload="{\"sha\": $(jq '.sha' <<<"$commit_response")}"
	# shellcheck disable=SC2034  # Unused variables left for readability
	update_branch_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
		-d "$update_branch_payload" \
		-X PATCH \
		"https://api.github.com/repos/${GITHUB_REPOSITORY}/git/${GITHUB_REF}")"

}

_commit_if_needed() {
	if _git_is_dirty; then
		_remote_commit
		_local_commit
	fi
}

_lint_and_fix_action() {
	if [[ $GITHUB_EVENT_NAME == "push" ]]; then
		if [[ ${2:-} == "autofix" ]]; then
			_requires_token
			fix
			_commit_if_needed
			lint
		else
			lint
		fi
	elif [[ $GITHUB_EVENT_NAME == "pull_request_review" ]]; then
		_requires_token
		_should_fix_review "fix $GITHUB_ACTION" || _should_fix_review "fix $1"
		fix
		_commit_if_needed
	fi

}

_lint_action() {
	if [[ ${GITHUB_EVENT_NAME} == "push" ]]; then
		lint "${@}"
	fi
}

_read_last_tag() {
	tag="$(git describe --tags --abbrev=0 --first-parent)"
	echo "${tag%%~*}"
}

_write_tag() {
	if [[ -z ${1:-} ]]; then
		version="$(cat)"
	else
		version="$1"
	fi

	git config --global user.name "github-actions[bot]"
	git config --global user.email "github-actions[bot]@users.noreply.github.com"
	git tag -f -a "$version" -m "Release ${version}"
	echo "${version}"
}

_autobump_version() {
	if [[ -z ${1:-} ]]; then
		version="$(cat)"
	else
		version="$1"
	fi

	IFS="." read -r major minor patch <<<"$version"

	patch=$((patch + 1))

	if [[ $patch -gt 999 ]]; then
		patch=0
		minor=$((minor + 1))
	fi

	if [[ $minor -gt 999 ]]; then
		patch=0
		minor=0
		major=$((major + 1))
	fi
	echo "${major:-0}.${minor:-0}.${patch:-0}"
}

_release_id() {
	local RELEASE_ID="$(jq --raw-output '.release.id' "$GITHUB_EVENT_PATH")"
	if [[ ${RELEASE_ID} == "null" ]]; then
		RELEASE_ID="$(curl --fail \
			-H "Authorization: token ${GITHUB_TOKEN}" \
			"https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/$TAG" |
			jq --raw-output '.id')"
	fi

	echo "$RELEASE_ID"
}

_upload_release() {
	local FILENAME="$1"
	local CONTENT_LENGTH_HEADER="Content-Length: $(stat -c%s "${FILENAME}")"
	local CONTENT_TYPE_HEADER="Content-Type: ${2:-application/zip}"
	local RELEASE_ID="$(_release_id)"
	local UPLOAD_URL="https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=${FILENAME}"

	curl \
		-XPOST \
		-H "Authorization: token ${GITHUB_TOKEN}" \
		-H "${CONTENT_LENGTH_HEADER}" \
		-H "${CONTENT_TYPE_HEADER}" \
		--upload-file "${FILENAME}" \
		"${UPLOAD_URL}"
}
