#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
	markdownlint .
}

main() {
	if [[ ${GITHUB_EVENT_NAME} == "push" ]]; then
		lint
	fi
}

main "${@}"
