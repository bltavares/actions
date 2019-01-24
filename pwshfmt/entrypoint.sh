#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	pwsh -c 'Get-ChildItem -Path . -Include *.ps1,*.psm1 -Recurse | Edit-DTWBeautifyScript -NewLine CRLF'
}

lint() {
	fix
	! _git_is_dirty
}

_lint_and_fix_action pwshfmt "${@}"
