#!/usr/bin/env bash

set -euo pipefail
set -x

source /lib.sh
source /releaser.sh

TARGET="x86_64-unknown-linux-musl"
PKG_NAME="${PKG_NAME:-$CRATE_NAME}"
CRATE_NAME="${CRATE_NAME:-$PKG_NAME}"
TYPE="${TYPE:-bin}"
TAG="${TAG:-$(_read_last_tag)}"

env

type=$(build-type)
$type-compile
$type-deploy
package

if _has_token; then
    publish
fi
