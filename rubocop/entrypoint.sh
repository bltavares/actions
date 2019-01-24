#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	rubocop --safe-auto-correct
}

lint() {
	rubocop
}

_lint_and_fix_action rubocop "${@}"
