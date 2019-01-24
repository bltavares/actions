#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	shfmt -s -w .
}

lint() {
	shfmt -s -l -d .
}

_lint_and_fix_action shfmt "${@}"
