# PHP-CS-Fixer action

## Validations on Push

This actions will check projects using [PHP-CS-Fixer](https://cs.symfony.com/)

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix php-cs-fixer`, a new
commit will be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["php-cs-fixer"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["php-cs-fixer"]
  on = "pull_request_review"
}

action "php-cs-fixer" {
  uses = "bltavares/actions/php-cs-fixer@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
