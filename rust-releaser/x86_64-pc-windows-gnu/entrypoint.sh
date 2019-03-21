#!/usr/bin/env bash

set -euo pipefail
set -x

TARGET="x86_64-pc-windows-gnu"
PKG_NAME="${PKG_NAME:-$CRATE_NAME}"
CRATE_NAME="${CRATE_NAME:-$PKG_NAME}"
TYPE="${TYPE:-bin}"
TAG="master"

env

source /lib.sh
source /releaser.sh

type=$(build-type)

$type-compile
$type-deploy
package
