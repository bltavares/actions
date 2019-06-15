#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

if [ -z "${SHFMT_ARGS:-}" ]; then
	SHFMT_ARGS=""
fi

fix() {
	shfmt -s -w ${SHFMT_ARGS} .
}

lint() {
	shfmt -s -l -d ${SHFMT_ARGS} .
}

_lint_and_fix_action shfmt "${@}"
