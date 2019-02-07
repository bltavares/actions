# clippy action

## Validations on Push

This actions will check the formating of a Rust project, using
[clippy](https://github.com/rust-lang-nursery/rust-clippy)
and [cargo-fix](https://github.com/rust-lang-nursery/rustfix)

`clippy` will not be able to fix things by itself, and `cargo-fix`
[so far](https://github.com/rust-lang-nursery/rustfix/issues/130) is not
supporting it as well, but it should in the future.

This action requires access to all dependencies of the project,
as the underlying tools will compile to lint. IT might need environment
variables to access private dependencies.

It is quite common that the image might need some C libraries and headers.
If that is the case, send a Pull Request to include it as a dependency.

## Fixes on Pull Request review

This action provides automated fixes using Pull Request review comments.

If the comment starts with `fix $action_name` or `fix clippy`, a new commit will
be added to the branch with the automated fixes applied.

**Supports**: autofix on push

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["clippy"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["clippy"]
  on = "pull_request_review"
}

action "clippy" {
  uses = "bltavares/actions/clippy@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["GITHUB_TOKEN"]
}
```
