# cljfmt action

## Validations on Push

This actions will check the formating of the project.

`cljfmt` plugin required to be installed on your project, as well as any variable needed to access all the dependencies of the project.

Given that this plugin uses `lein cljfmt`, it might need extra environment variable and secrets, such as `AWS_ACCESS_KEY_ID` and `AWS_ACCESS_KEY_KEY`.

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix cljfmt`, a new commit will be added to the branch with the automated fixes applied.

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["cljfmt"]
}

workflow "on review" {
  resolves = ["cljfmt"]
  on = "pull_request_review"
}

action "cljfmt" {
  uses = "bltavares/actions/cljfmt@master"
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
