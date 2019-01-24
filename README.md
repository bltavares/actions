# Github Actions

Useful GitHub Actions to help build software.
Detailed documentation on how to use each action located on their folder.

## Provided actions

### Linters and Formatters

<!-- markdownlint-disable MD013 -->
| Action                   | Description          | Lint on Push | Fix with Review | Autofix on Push |
|--------------------------|----------------------|--------------|-----------------|-----------------|
| [cljfmt](cljfmt)         | Clojure formatter    | x            | x               |x                |
| [pwshfmt](pwshfmt)       | Powershell Formatter | x            | x               |x                |
| [rubocop](rubocop)       | Ruby linter          | x            | x               |x                |
| [shfmt](shfmt)           | Shell formatter      | x            | x               |x                |
| [hadolint](hadolint)     | Dockerfile linter    | x            |                 |                 |
| [mdlint](mdlint)         | Markdown linting     | x            |                 |                 |
| [shellcheck](shellcheck) | Bash linter          | x            |                 |                 |
<!-- markdownlint-enable MD013 -->

#### Fixes by Review comments

#### Autofix on push

##### :warning: Caveats

## Building

This project uses [nektos/act](https://github.com/nektos/act) to test changes
locally, and requires it to be installed.

To keep all the `lib.sh` updated and validate the project itself, run:

```bash
make
```

If you need to skip linting, as it might need to copy the lib before properly linting:

```bash
make -W lint
```
