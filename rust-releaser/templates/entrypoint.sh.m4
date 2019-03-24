#!/usr/bin/env bash

set -euo pipefail

source /lib.sh
source /releaser.sh

TARGET="COMPILE_TARGET"
PKG_NAME="${PKG_NAME:-$CRATE_NAME}"
CRATE_NAME="${CRATE_NAME:-$PKG_NAME}"
TYPE="${TYPE:-bin}"
TAG="${TAG:-$(_read_last_tag)}"

type=$(build-type)
$type-compile
$type-deploy
package

if _has_token; then
    publish
fi
