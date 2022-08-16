#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	lein ancient upgrade :no-tests :only :autobump
}

lint() {
	lein ancient upgrade :no-tests :only :autobump
}

_lint_and_fix_action lein-ancient "${@}"
