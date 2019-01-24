#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	lein cljfmt fix
}

lint() {
	lein cljfmt check
}

_lint_and_fix_action cljfmt "${@}"
