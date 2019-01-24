#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
    tslint --project .
}

fix() {
    tslint --project . --fix
}

_lint_and_fix_action tslint "${@}"
