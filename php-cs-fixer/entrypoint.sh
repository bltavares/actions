#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	php-cs-fixer fix --dry-run -v --diff
}

fix() {
	php-cs-fixer fix
}

_lint_and_fix_action php-cs-fixer "${@}"
