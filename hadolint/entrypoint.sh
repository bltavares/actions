#!/bin/bash

set -euo pipefail

source lib.sh

lint() {
    find . -name 'Dockerfile' -type f -exec hadolint {} +
}

main() {
    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    fi
}

main "${@}"
