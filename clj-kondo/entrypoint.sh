#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	clj-kondo --lint src
}

_lint_action clj-kondo "${@}"
