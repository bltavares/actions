# sh action

Based on [@actions' sh](https://github.com/actions/bin/tree/master/sh), with
more utilities available

## Usage

Executes each command listed in the Action's `args` via `bash -c`.

The `lib.sh` functions are available on the container, at `/lib.sh`, if scripts
would like to use the functions.

```hcl
action "Shell" {
  uses = "bltavares/actions/bash@master"
  args = ["ls -ltr"]
}
```
