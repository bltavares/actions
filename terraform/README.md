# terraform action

## Validations on Push

This actions will check the formatting of the project, using
[terraform fmt](https://github.com/hashicorp/terraform).

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix terraform`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["terraform"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["terraform"]
  on = "pull_request_review"
}

action "terraform" {
  uses = "bltavares/actions/terraform@master"

  # Enable autofix on push
  # args = ["autofix"]

  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]

  # Pass in extra args
  # env = {
  #   EXTRA_ARGS = "--recursive"
  # }
}
```
