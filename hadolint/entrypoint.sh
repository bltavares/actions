#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	find . -name 'Dockerfile' -type f -exec hadolint {} +
}

_lint_action "${@}"
