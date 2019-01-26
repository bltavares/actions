#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	cargo fmt
}

lint() {
	cargo fmt -- --check
}

_lint_and_fix_action rustfmt "${@}"
