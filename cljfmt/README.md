# cljfmt action

## Validations on Push

This actions will check the formatting of the project, using
[cljfmt](https://github.com/weavejester/cljfmt).

This action make use of `tool.deps` instead of `lein`, which provides global
execution of `cljfmt` without needing to use the `lein` plugin. This way, you
are able to format the project without providing access to any project
dependencies.

For configuration, this action will inspect the existence of the following files
on the project, and pass them in to `cljfmt`:

- `.cljfmt-alias.edn`
  [:alias-map](https://github.com/weavejester/cljfmt#configuration) map config
  content

- `.cljfmt-indent.edn`
  [:indents](https://github.com/weavejester/cljfmt#indentation-rules) map config
  content

Alternatively, there is [zprint](../zprint) action available.

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix cljfmt`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["cljfmt"]
}

# Used for fix on review
workflow "on review" {
  resolves = ["cljfmt"]
  on = "pull_request_review"
}

action "cljfmt" {
  uses = "bltavares/actions/cljfmt@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
