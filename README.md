Create a file named `whatever_name.yml` inside the `.github/workflows` directory and paste:

```yml
name: Bash Pull Request Merger

on: [pull_request]

jobs:
  bash-pr-merger:
    runs-on: ubuntu-latest
    name: Merge pull requests when there is only a composer.lock file
    steps:
      - uses: tanoka/automerge-action@master
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## ⚖️ License

[MIT](LICENSE)
