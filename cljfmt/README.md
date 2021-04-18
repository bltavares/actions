# cljfmt action

## Validations on Push

This actions will check the formatting of the project, using
[cljfmt](https://github.com/weavejester/cljfmt).

This action makes use of `tool.deps` instead of `lein`, which provides global
execution of `cljfmt` without needing to use the `lein` plugin. This way, you
are able to format the project without providing access to any project
dependencies.

For configuration, this action will inspect the existence of the following files
on the project, and pass them in to `cljfmt`:

- `.cljfmt-alias.edn`
  [:alias-map](https://github.com/weavejester/cljfmt#configuration) map config
  content

- `.cljfmt-indents.edn`
  [:indents](https://github.com/weavejester/cljfmt#indentation-rules) map config
  content

In order to pass root level configuration parameter to `cljfmt`, it needs to be specified in workflow YAML via args.

```yaml
name: Clojure linter
on:
  push
jobs:
  clojureLint:
    runs-on: ubuntu-latest
steps:
  - uses: actions/checkout@v2
  - uses: bltavares/actions/cljfmt@1.0.10
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    with:
      args: src test extra-src-path --no-remove-consecutive-blank-lines
```

More `cljfmt` options can be found [here](https://github.com/weavejester/cljfmt/blob/master/cljfmt/src/cljfmt/main.clj#L169-L200).

## Validations on Pull Request

Start lint action each time when PR opened or source branch updated (synchronize).

```yaml
name: Clojure linter
on:
  pull_request:
    types: [opened, synchronize]
jobs:
  clojureLint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: bltavares/actions/cljfmt@1.0.10
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          args: src test extra-src-path
```

## Fixes on Push

This action provides automated fixes, action will start on push event and a new commit will be added to the branch with the automated fixes applied.

```yaml
name: Clojure linter
on:
  push
jobs:
  clojureLint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: bltavares/actions/cljfmt@1.0.10
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          args: autofix src test extra-src-path
```

## Fixes on Pull Request review

Action will start when PR review submitted and if the comment starts with `fix $action_name` or `fix cljfmt`, a new commit will be added to the branch with the automated fixes applied.

```yaml
name: Clojure linter
on:
  pull_request_review:
    types: [submitted]
jobs:
  cljfmt:
    runs-on: ubuntu-latest
    # skip running unless comment starts with `fix cljfmt`
    if: ${{ startsWith( github.event.review.body, 'fix cljfmt' )}}
    steps:
      - uses: actions/checkout@v2
      - uses: bltavares/actions/cljfmt@1.0.10
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          # Pass PR head ref for Pull Request review, required for autofix commit
          GITHUB_PR_HEAD_REF: ${{ github.event.pull_request.head.ref }}
        with:
          args: autofix src test extra-src-path
```

Alternatively, there is [zprint](../zprint) action available.