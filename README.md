# Github Actions

Useful GitHub Actions to validate changes and provide lint fixes.

Detailed documentation on how to use each action located on their folder.

### Provided actions


| Action                   | Description          | Lint on Push | Fix on Review |
|--------------------------|----------------------|--------------|---------------|
| [cljfmt](cljfmt)         | Clojure formatter    | x            | x             |
| [shfmt](shfmt)           | Shell formatter      | x            | x             |
| [pwshfmt](pwshfmt)       | Powershell Formatter | x            | x             |
| [hadolint](hadolint)     | Dockerfile linter    | x            |               |
| [shellcheck](shellcheck) | Bash linter          | x            |               |

## Building

This project uses [nektos/act](https://github.com/nektos/act) to test changes locally, and requires it to be installed.

To keep all the `lib.sh` updated and validate the project itself, run:

```
make
```
