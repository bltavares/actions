#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh
declare -a file_args=()

cljfmt() {
	clojure -Sdeps '{:deps {lein-cljfmt {:mvn/version "0.6.4"}}}' \
		-m cljfmt.main "${file_args[@]}" "$@"
}

fix() {
	cljfmt fix
}

lint() {
	cljfmt check
}

setup_files() {
	if [[ -f .cljfmt-indents.edn ]]; then
		file_args+=(--indents .cljfmt-indents.edn)
	fi

	if [[ -f .cljfmt-alias.edn ]]; then
		file_args+=(--alias-map .cljfmt-alias.edn)
	fi
}

setup_files
_lint_and_fix_action cljfmt "${@}"
