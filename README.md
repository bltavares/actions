# actions


```bash
action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
pr_url=$(jq --raw-output .pull_request.url "$GITHUB_EVENT_PATH")
```
