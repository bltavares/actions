# clj autoupdate action

:warning:
This action is focused on a particular set of projects, and it might not be
widely usable on a wide variety of projects. There is no intention on making it
wide-available and accommodate general project setups.

This action provides automated update of a Clojure dependencies whenever a new
PR is pushed, or when there is a review asking for it.

## Example workflow: PR autofix

```hcl
workflow "on push" {
  on = "push"
  resolves = ["autobump"]
}

actions "only PRs" {
  uses = "actions/bin/filter@master"
  args = "ref refs/pulls/*"
}

action "autobump" {
  uses = "bltavares/actions/clj-autoupdate@master"
  needs = ["only PRs"]

  # Enable autofix on push
  args = ["autofix"]

  # Used for pushing changes for `fix` comments on review
  # And for retrieving dependencies from AWS
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY"
  ]
  env {
    BUCKET_PATH = "s3://bucket-name/path"
    PREFIX = "common"
  }
}
```

## Example workflow: Review fixes

Comment `fix autobump` (the action name on this workflow) or `fix
clj-autoupdate` (the default name of the action) to have it fix.

Validation is provided by push checks.

```hcl
# Used for fix on review
workflow "on review" {
  resolves = ["cljfmt"]
  on = "pull_request_review"
}

workflow "on push" {
  on = "push"
  resolves = ["autobump"]
}

action "autobump" {
  uses = "bltavares/actions/clj-autoupdate@master"

  # Used for pushing changes for `fix` comments on review
  # And for retrieving dependencies from AWS
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY"
  ]
  env {
    BUCKET_PATH = "s3://bucket-name/path"
    PREFIX = "common"
  }
}
```
