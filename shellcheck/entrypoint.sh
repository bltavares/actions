#!/bin/bash

set -euo pipefail

source lib.sh

lint() {
    find . -name '*.sh' -type f -exec shellcheck -a {} +
}

main() {
    if [[ "${GITHUB_EVENT_NAME}" == "push" ]]; then
        lint
    fi
}

main "${@}"
