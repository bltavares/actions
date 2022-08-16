#!/usr/bin/env bash

set -euo pipefail

source /lib.sh

_requires_token

output="$(_read_last_tag | _autobump_version | _write_tag)"
tag="$(_read_last_tag)"

curl --fail \
	-H "Authorization: token ${GITHUB_TOKEN}" \
	-d "{\"tag_name\": \"$tag\", \"target_commitish\": \"${GITHUB_SHA}\", \"name\": \"Release $tag\", \"prerelease\": true}" \
	"https://api.github.com/repos/${GITHUB_REPOSITORY}/releases"
