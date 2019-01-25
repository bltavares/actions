#!/bin/bash

set -euo pipefail
set -x

# shellcheck disable=SC1091
source /lib.sh

fix() {
	dartfmt -w --fix .
}

lint() {
	dartfmt -n --fix . && dart-analyzer
}

_lint_and_fix_action dartfmt "${@}"
