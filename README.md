# SPV Wallet tool Components Chart Repository

## Chart release process

To update app version in charts use the following script:

```bash
./update
```

> Note: Script requires `yq` and `gh` to be locally installed. It will be checked & installed during the script execution.

Releasing will happen automatically after pushing your changes into main branch. See [release.yaml](.github%2Fworkflows%2Frelease.yaml)

Chart is attached to the github release and index.yaml is updated on the gh-pages branch which is deployed as github pages.
