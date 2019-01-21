#!/bin/bash

set -xeo pipefail

lint() {
    curl -H "Authorization: token ${GITHUB_TOKEN}" \
         --fail \
         -d "{\"state\":\"pending\",\"context\": \"${GITHUB_ACTION}\"}" \
         https://api.github.com/repos/${GITHUB_REPOSITORY}/statuses/${GITHUB_SHA}

    if lein cljfmt check;  then
        curl -H "Authorization: token ${GITHUB_TOKEN}" \
             --fail \
             -d "{\"state\":\"success\",\"context\": \"${GITHUB_ACTION}\"}" \
             https://api.github.com/repos/${GITHUB_REPOSITORY}/statuses/${GITHUB_SHA}
    else
        curl -H "Authorization: token ${GITHUB_TOKEN}" \
             --fail \
             -d "{\"state\":\"failure\",\"context\": \"${GITHUB_ACTION}\"}" \
             https://api.github.com/repos/${GITHUB_REPOSITORY}/statuses/${GITHUB_SHA}
    fi
    exit 0
}

fix() {
    lein cljfmt fix

    git config credential.helper 'cache --timeout=120'
    git config user.email "github-actions@example.com"
    git config user.name "cljfmt fix"
    git add .
    git commit -m "Apply cljfmt fix"
    git push -q https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git ${GITHUB_REF}
}

main() {
    [[ -z "$GITHUB_TOKEN" ]] && echo "Set the GITHUB_TOKEN env variable." && exit 1

    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    elif [[ "$GITHUB_EVENT_NAME" == "" ]]; then
        echo "Comment"
    fi
}

main
