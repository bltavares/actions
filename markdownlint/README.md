# markdownlint action

## Validations on Push

This actions will check markdown files using
[markdownlint](https://github.com/markdownlint/markdownlint)

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["markdownlint"]
}

action "markdownlint" {
  uses = "bltavares/actions/markdownlint@master"
}
```