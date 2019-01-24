# tslint action

## Validations on Push

This actions will check the formating of the Dockerfiles in the project,
using [tslint](https://github.com/palantir/tslint)

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["tslint"]
}

action "cljfmt" {
  uses = "bltavares/actions/tslint@master"
}
```
