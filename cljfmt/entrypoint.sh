#!/bin/bash

set -eo pipefail

fix() {
    lein cljfmt fix

    [[ -z $(git status -s) ]] && {
        git config credential.helper 'cache --timeout=120'
        git config user.email "github-actions@example.com"
        git config user.name "cljfmt fix"
        git add .
        git commit -m "Apply cljfmt fix"
        git push -q https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git ${GITHUB_REF}
    }
}

main() {
    [[ -z "$GITHUB_TOKEN" ]] && echo "Set the GITHUB_TOKEN env variable." && exit 1

    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lein cljfmt check
    elif [[ "$GITHUB_EVENT_NAME" == "pull_request_review" ]]; then
        fix
    fi
}

main
