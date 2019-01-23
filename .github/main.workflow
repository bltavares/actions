workflow "Check changes" {
  on = "push"
  resolves = "lint"
}

workflow "On review" {
  on = "pull_request_review"
  resolves = "fixes"
}

action "lint" {
  needs = ["shellcheck", "hadolint", "shfmt"]
  uses = "actions/bin/sh@master"
  args = ["true"]
}

action "fixes" {
  needs = ["shfmt""]
  uses = "actions/bin/sh@master"
  args = ["true"]
}

action "shellcheck" {
  uses = "./shellcheck"
}

action "hadolint" {
  uses = "./hadolint"
}

action "shfmt" {
  uses = "./shfmt"
  secrects = ["GITHUB_TOKEN"]
}