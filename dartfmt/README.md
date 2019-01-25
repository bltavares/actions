# dartfmt action

## Validations on Push

This actions will check the formating of a Dart (or Flutter) project,
using [dartfmt](https://github.com/dart-lang/dart_style) and
[dartanalyzer](https://github.com/dart-lang/linter)

This action profides `dartfmt` fixes, but no fix
[support by dartanalyzer](https://github.com/dart-lang/linter/issues/1374)
yet.

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix dartfmt`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["dartfmt"]
}

workflow "on review" {
  resolves = ["dartfmt"]
  on = "pull_request_review"
}

action "dartfmt" {
  uses = "bltavares/actions/dartfmt@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
