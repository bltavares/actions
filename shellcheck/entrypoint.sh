#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	find . -name '*.sh' -type f -exec shellcheck -a {} +
}

_lint_action "${@}"
