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

setup() {
    echo '{:search-config? true}' > ~/.zprint.edn \
        && boot -d boot-fmt:0.1.8 -d zprint:0.4.15 fmt --help > /dev/null
}

setup
_lint_and_fix_action zprint "${@}"
