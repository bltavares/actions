# Github Actions

Useful GitHub Actions to validate changes and provide lint fixes.

Detailed documentation on how to use each action located on their folder.

## Provided actions

<!-- markdownlint-disable MD013 -->
| Action                   | Description          | Lint on Push | Fix on Review |
|--------------------------|----------------------|--------------|---------------|
| [cljfmt](cljfmt)         | Clojure formatter    | x            | x             |
| [pwshfmt](pwshfmt)       | Powershell Formatter | x            | x             |
| [rubocop](rubocop)       | Ruby linter          | x            | x             |
| [shfmt](shfmt)           | Shell formatter      | x            | x             |
| [hadolint](hadolint)     | Dockerfile linter    | x            |               |
| [mdlint](mdlint)         | Markdown linting     | x            |               |
| [shellcheck](shellcheck) | Bash linter          | x            |               |
<!-- markdownlint-enable MD013 -->

## Building

This project uses [nektos/act](https://github.com/nektos/act) to test changes
locally, and requires it to be installed.

To keep all the `lib.sh` updated and validate the project itself, run:

```bash
make
```
