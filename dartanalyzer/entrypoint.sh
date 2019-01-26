#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

lint() {
  if [[ ${1:-dart} == "dart" ]]; then
    pub get && dartanalyzer .
  elif [[ $1 == "flutter" ]]; then
    flutter analyze
  else
    echo "Not a valid argument for the action"
    echo "Options are either empty, dart or flutter".
    exit 1
  fi
}

_lint_action "${@}"
