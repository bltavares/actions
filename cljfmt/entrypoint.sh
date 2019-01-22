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
        git config credential.helper 'cache --timeout=120'
        git config user.email "github-actions@example.com"
        git config user.name "cljfmt fix"
        git add .
        git commit -m "Apply cljfmt fix"
        git push -q https://lint:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY} $(git rev-parse --abbrev-ref HEAD)
    fi
}

_should_fix_review() {
    fix_comment="$( jq --raw-output '.review.body | select(. | startswith("lint fix"))' "$GITHUB_EVENT_PATH")"
    [[ -n "$fix_comment" ]] || exit 0
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
