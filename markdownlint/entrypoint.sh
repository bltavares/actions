#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	markdownlint .
}

_lint_action markdownlint "${@}"