# kubeval action

## Validations on Push

This actions will Kubernets (k8s) in the project, using
[kubeval](https://github.com/garethr/kubeval)

The action by default search for all `yaml` or `yml` files on the project to
lint, but it is possible to specify a folder to search.

## Example workflow

```hcl
workflow "on push" {
  on = "push"
  resolves = ["kubeval"]
}

action "cljfmt" {
  uses = "bltavares/actions/kubeval@master"
  # optionally provide path to yamls
  # args = ["folder/to/yamls"]
}
```
