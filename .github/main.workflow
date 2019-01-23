workflow "Check changes" {
 on = "push"
 resolves = "lint"
}

action "lint" {
  needs = ["shellcheck", "hadolint"]
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
}