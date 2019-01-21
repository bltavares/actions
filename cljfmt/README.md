


```hcl
workflow "on push" {
  on = "push"
  resolves = ["cljfmt lint"]
}

action "cljfmt lint" {
  uses = "./../actions/cljfmt"
  secrets = ["GITHUB_TOKEN"]
}
```
