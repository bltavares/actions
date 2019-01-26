#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	dartfmt -w --fix .
}

lint() {
	dartfmt -n --fix .
}

_lint_and_fix_action dartfmt "${@}"
