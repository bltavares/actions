#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

fix() {
	rubocop --safe-auto-correct
}

lint() {
	rubocop
}

main() {
	if [[ ${GITHUB_EVENT_NAME} == "push" ]]; then
		lint
	elif [[ $GITHUB_EVENT_NAME == "pull_request_review" ]]; then
		_requires_token
		_should_fix_review "fix $GITHUB_ACTION" || _should_fix_review "fix rubocop"
		fix
		_commit_if_needed
	fi
}

main "${@}"
