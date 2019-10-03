#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	yamllint .
}

fix() {
	yamllint . --fix
}

_lint_and_fix_action yamllint "${@}"
