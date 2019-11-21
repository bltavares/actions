# cljfmt action

## Validations on Push

This actions will check the formatting of the project, using
[cljfmt](https://github.com/weavejester/cljfmt).

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix cljfmt`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```yaml
name: Clojure linter
on:
  push # change to "pull_request_review" for running on PR reviews
jobs:
  clojureLint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: bltavares/actions/cljfmt@1.0.8
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          args: autofix
```
