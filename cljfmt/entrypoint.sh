#!/bin/bash

set -euo pipefail
set -x

# shellcheck disable=SC1091
source /lib.sh

fix() {
    lein cljfmt fix
}

lint() {
    lein cljfmt check
}

main() {
    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    elif [[ "$GITHUB_EVENT_NAME" == "pull_request_review" ]]; then
        _requires_token
        _should_fix_review "fix $GITHUB_ACTION" || _should_fix_review "fix cljfmt"
        fix
        _commit_if_needed
    elif [[ "$GITHUB_EVENT_NAME" == "TODO_issue_comment" ]]; then
        _requires_token
        _should_fix_issue "fix $GITHUB_ACTION" || _should_fix_issue "fix cljfmt"
        # TODO: I'm unable to get the branch given an issue comment event
        _switch_to_branch
        fix
        _commit_if_needed
    fi
}

main "${@}"
