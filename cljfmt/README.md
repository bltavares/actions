
```hcl
workflow "on push" {
  on = "push"
  resolves = ["cljfmt"]
}

workflow "on review" {
  resolves = ["cljfmt"]
  on = "pull_request_review"
}

action "cljfmt" {
  uses = "bltavares/actions/cljfmt@cljfmt-actions"
  secrets = ["GITHUB_TOKEN"]
}
```
