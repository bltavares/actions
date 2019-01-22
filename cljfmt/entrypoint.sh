#!/bin/bash

set -eo pipefail

fix() {
    lein cljfmt fix
}

lint() {
   lein cljfmt check
}

_should_fix() {
    pr_url="$(jq --raw-output '.issue.pull_request.url | select(. != null)' "$GITHUB_EVENT_PATH")"
    fix_comment="$( jq --raw-output '.comment.body | select(. | startswith("lint fix"))' "$GITHUB_EVENT_PATH")"
    [[ -n "$pr_url" ]] && [[ -n "$fix_comment" ]] || exit 0
}

_switch_to_branch() {
git branch -v
git rev-parse --abbrev-ref HEAD
  git checkout ${GITHUB_SHA}
  git branch -v
  git rev-parse --abbrev-ref HEAD

}

_commit_if_needed() {
    [[ -z "$(git status -s)" ]] && {
        git config credential.helper 'cache --timeout=120'
        git config user.email "github-actions@example.com"
        git config user.name "cljfmt fix"
        git add .
        git commit -m "Apply cljfmt fix"
        git push -q https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git $(git rev-parse --abbrev-ref HEAD)
    } || true
}

main() {
    [[ -z "$GITHUB_TOKEN" ]] && echo "Set the GITHUB_TOKEN env variable." && exit 1

    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    elif [[ "$GITHUB_EVENT_NAME" == "issue_comment" ]]; then
        _should_fix
        _switch_to_branch
        fix
        _commit_if_needed
    fi
}

main
