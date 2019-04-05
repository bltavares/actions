#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	git --no-pager diff origin/master --name-only | xargs npx prettier --check
}

fix() {
	git --no-pager diff origin/master --name-only | xargs npx prettier --write
}

_lint_and_fix_action prettier "${@}"
