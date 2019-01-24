workflow "Check changes" {
  on = "push"
  resolves = ["lint", "fixes"]
}

workflow "On review" {
  on = "pull_request_review"
  resolves = "fixes"
}

action "lint" {
  needs = ["shellcheck", "hadolint", "mdlint", "kubeval"]
  uses = "actions/bin/sh@master"
  args = ["true"]
}

action "fixes" {
  needs = ["shfmt", "pwshfmt", "rubocop"]
  uses = "actions/bin/sh@master"
  args = ["true"]
}

action "shellcheck" {
  uses = "./shellcheck"
}

action "hadolint" {
  uses = "./hadolint"
}

action "mdlint" {
  uses = "./mdlint"
}

action "kubeval" {
  uses = "./kubeval"
}

action "shfmt" {
  uses = "./shfmt"
  args = ["autofix"]
  secrets = ["GITHUB_TOKEN"]
}

action "rubocop" {
  needs = ["shfmt"]
  uses = "./rubocop"
  args = ["autofix"]
  secrets = ["GITHUB_TOKEN"]
}

action "pwshfmt" {
  needs = ["rubocop"]
  uses = "./pwshfmt"
  args = ["autofix"]
  secrets = ["GITHUB_TOKEN"]
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}