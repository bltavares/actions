#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
    find "${1:-.}" -name '*.yml' -or -name '*.yaml' -exec hadolint {} +
}

_lint_action "${@}"
