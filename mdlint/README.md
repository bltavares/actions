# mdlint action

## Validations on Push

This actions will check the formating of the Dockerfiles in the project,
using [markdownlint](https://github.com/igorshubovych/markdownlint-cli)

Action name was changed just to provide a shorter version

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["mdlint"]
}

action "mdlint" {
  uses = "bltavares/actions/mdlint@master"
}
```
