# clj-kondo action

## Validations on Push

This actions will check the formatting of the project, using
[clj-kondo](https://github.com/weavejester/clj-kondo).

This action make use of `tool.deps` instead of `lein`, which provides global
execution of `clj-kondo` without needing to use the `lein` plugin. This way, you
are able to format the project without providing access to any project
dependencies.

For configuration, this action will inspect the existence of the following files
on the project, and pass them in to `clj-kondo`:

- `.clj-kondo-alias.edn`
  [:alias-map](https://github.com/weavejester/clj-kondo#configuration) map config
  content

- `.clj-kondo-indents.edn`
  [:indents](https://github.com/weavejester/clj-kondo#indentation-rules) map config
  content

Alternatively, there is [zprint](../zprint) action available.

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix clj-kondo`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["clj-kondo"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["clj-kondo"]
  on = "pull_request_review"
}

action "clj-kondo" {
  uses = "bltavares/actions/clj-kondo@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
