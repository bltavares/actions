# rustfmt action

## Validations on Push

This actions will check the formating of a Rust project, using
[rustfmt](https://github.com/rust-lang/rustfmt)

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix rustfmt`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["rustfmt"]
}

workflow "on review" {
  resolves = ["rustfmt"]
  on = "pull_request_review"
}

action "rustfmt" {
  uses = "bltavares/actions/rustfmt@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
