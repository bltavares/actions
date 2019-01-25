# dartanalyzer action

## Validations on Push

This actions will check the formating of a Dart (or Flutter) project,
using [dartanalyzer](https://github.com/dart-lang/sdk/tree/master/pkg/analyzer_cli).

`dartanalyzer` needs to download all dependencies to properly analyze the project,
and it will execute a `pub get` before running. Make sure all necessary environment
variables are provided to access all dependencies.

When using this action to analyze a Flutter project, pass it `args = ["flutter]` ir order
to access the Flutter SDK.

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["dartanalyzer"]
}

action "dartanalyzer" {
  uses = "bltavares/actions/dartanalyzer@master"
  # Analyze Flutter project
  # args = ["flutter"]
}
```
