#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

version() {
	library="$1"
	all_versions=$(aws s3 ls "${BUCKET_PATH}/${library}/${library}/" --region "${AWS_REGION:-sa-east-1}" | sed -nE 's/.*PRE (.+)\/.*/\1/p')

	current_major=$(sed -n "s/^.*\[${library} *\"\([0-9]*\).*$/\1/p" project.clj)
	filtered_versions=$(echo "$all_versions" | grep -xE "${current_major}\.[0-9]+\.[0-9]+")

	echo "$filtered_versions" | sort -V | tail -n 1
}

fix() {
	project_name=$(grep defproject project.clj | awk '{print $2}')
	deps=$(grep -v "$project_name" project.clj | grep "$PREFIX" | sed -r 's/.*\[([^ ]+) .*/\1/')

	for dep in $deps; do
		echo "Bumping $dep"
		dep_version=$(version "$dep")
		echo "$dep_version"
		sed -r -i "s/^(.*$dep +\")[^\"]+(\".*)$/\1$dep_version\2/" project.clj
	done
}

lint() {
	fix
	! _git_is_dirty
}

_lint_and_fix_action clj-autoupdate "${@}"
