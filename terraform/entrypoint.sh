#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	# shellcheck disable=SC2086
	terraform fmt -write=true $EXTRA_ARGS
}

lint() {
	# shellcheck disable=SC2086
	terraform fmt -check=true -write=false $EXTRA_ARGS
}

_lint_and_fix_action terraform "${@}"
