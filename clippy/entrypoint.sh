#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	cargo fix
}

lint() {
	cargo clippy --all-targets --all-features -- -W forbid
}

_lint_and_fix_action clippy "${@}"
