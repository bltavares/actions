
```hcl
workflow "on push" {
  on = "push"
  resolves = ["cljfmt lint"]
}

action "cljfmt lint" {
  uses = "bltavares/actions/cljfmt@master"
  secrets = ["GITHUB_TOKEN"]
}
```
