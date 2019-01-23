#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	pwsh -c 'Get-ChildItem -Path . -Include *.ps1,*.psm1 -Recurse | Edit-DTWBeautifyScript -NewLine CRLF'
}

set -x
lint() {
	fix
	! _git_is_dirty
}

main() {
	if [[ ${GITHUB_EVENT_NAME} == "push" ]]; then
		lint
	elif [[ $GITHUB_EVENT_NAME == "pull_request_review" ]]; then
		_requires_token
		_should_fix_review "fix $GITHUB_ACTION" || _should_fix_review "fix pwshfmt"
		fix
		_commit_if_needed
	fi
}

main "${@}"
