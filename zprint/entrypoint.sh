#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	boot -d boot-fmt -d zprint fmt --git --mode overwrite --really
}

lint() {
	boot -d boot-fmt -d zprint fmt --git --mode list
}

_lint_and_fix_action zprint "${@}"
