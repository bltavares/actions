# yamllint action

## Validations on Push

This actions will check YAML files using
[yamllint](https://github.com/adrienverge/yamllint)

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix yamllint`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["yamllint"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["yamllint"]
  on = "pull_request_review"
}

action "yamllint" {
  uses = "bltavares/actions/yamllint@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
