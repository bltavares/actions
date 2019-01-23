workflow "Check changes" {
 on = "push"
 resolves = "shellcheck"
}

action "shellcheck" {
  uses = "./shellcheck"
}