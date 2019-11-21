#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

rewrite() {
	clojure -Sdeps '{:deps {rewrite-clj {:mvn/version "0.6.1"}}}' /rewrite_projectclj.clj
}

cljfmt() {
	rewrite
	lein cljfmt "$@"
	git checkout -- project.clj
}

fix() {
	rewrite
	lein cljfmt fix
	git checkout -- project.clj
}

lint() {
	rewrite
	lein cljfmt check
	git checkout -- project.clj
}

_lint_and_fix_action cljfmt "${@}"
