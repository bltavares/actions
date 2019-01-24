# shellcheck action

## Validations on Push

This actions will check the formating of the Dockerfiles in the project, using [shellcheck](https://github.com/koalaman/shellcheck/)

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["shellcheck"]
}

action "shellcheck" {
  uses = "bltavares/actions/shellcheck@master"
}
```
