#!/bin/bash

set -euo pipefail
set -x

fix() {
    lein cljfmt fix
}

lint() {
    lein cljfmt check
}

_should_fix_issue() {
    pr_url="$(jq --raw-output '.issue.pull_request.url | select(. != null)' "$GITHUB_EVENT_PATH")"
    fix_comment="$( jq --raw-output '.comment.body | select(. | startswith("lint fix"))' "$GITHUB_EVENT_PATH")"
    [[ -n "$pr_url" ]] && [[ -n "$fix_comment" ]] || exit 0
}

_switch_to_branch() {
    remote_branch_name=$(git name-rev --name-only "${GITHUB_SHA}")
    git checkout -b "${remote_branch_name#remotes/origin}" --track "$remote_branch_name"
}

_commit_if_needed() {
    if [[ -n "$(git status -s)" ]]; then
        tmp_file=$(mktemp)

        while read src_mode dst_mode src_sha dst_sha flag path; do
            file_payload="""
{
  \"encoding\": \"base64\",
  \"content\": \"$(base64 $path | tr -d '\n')\"
}"""
            file_response=$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
                                 -d "$file_payload" \
                                 https://api.github.com/repos/${GITHUB_REPOSITORY}/git/trees)
            echo "{ \"mode\": \"${dst_mode}\", \"path\": \"${path}\", \"sha\": \"$(jq '.sha' <<<"$file_response")\"}" >> $tmp_file
        done < <(git diff-files)

        tree_payload="""
{
  \"base_tree\": \"${GITHUB_SHA}\",
  \"tree\": $(jq -s '.' "$tmp_file")
}
"""
        tree_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
                             -d "$tree_payload" \
                             https://api.github.com/repos/${GITHUB_REPOSITORY}/git/trees)"

        commit_payload="""
{
    \"message\": \"lint fix\",
    \"tree\": $(jq '.sha' <<<"$tree_response"),
    \"parents\": [\"${GITHUB_SHA}\"]
}
"""
        commit_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
                               -d "$commit_payload" \
                               https://api.github.com/repos/${GITHUB_REPOSITORY}/git/commits)"

        update_branch_payload="""
{
\"sha\": $(jq '.sha' <<<"$commit_response")
}
"""

        update_branch_response="$(curl --fail -H "Authorization: token ${GITHUB_TOKEN}" \
                                      -d "$update_branch_payload" \
                                      -X PATCH \
                                      https://api.github.com/repos/${GITHUB_REPOSITORY}/git/${GITHUB_REF})"
    fi
}

_should_fix_review() {
    fix_comment="$( jq --raw-output '.review.body | select(. | startswith("lint fix"))' "$GITHUB_EVENT_PATH")"
    [[ -n "$fix_comment" ]] || exit 78
}

main() {
    [[ -z "$GITHUB_TOKEN" ]] && echo "Set the GITHUB_TOKEN env variable." && exit 1

    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    elif [[ "$GITHUB_EVENT_NAME" == "pull_request_review" ]]; then
        _should_fix_review
        fix
        _commit_if_needed
    elif [[ "TODO$GITHUB_EVENT_NAME" == "issue_comment" ]]; then
        _should_fix_issue
        # TODO: I'm unable to get the branch given an issue comment event
        _switch_to_branch
        fix
        _commit_if_needed
    fi
}

main "${@}"
