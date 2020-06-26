Create a file named `whatever_name.yml` inside the `.github/workflows` directory and paste:

```yml
name: Bash GH Skeleton

on: [pull_request]

jobs:
  bash-gh-skeleton:
    runs-on: ubuntu-latest
    name: Whatever this action does
    steps:
      - uses: tanoka/automerge-action@master
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## ⚖️ License

[MIT](LICENSE)
