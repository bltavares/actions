#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	shfmt -s -w ${SHFMT_ARGS:-} .
}

lint() {
	shfmt -s -l -d ${SHFMT_ARGS:-} .
}

_lint_and_fix_action shfmt "${@}"
