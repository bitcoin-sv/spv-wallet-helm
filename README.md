# Bux Components Chart Repository

## Chart release process

- Update appVersion in Chart.yaml for each component with a new image
- Update version in Chart.yaml for all components
- Package new chart
```console
helm package bux-helm
```
- Copy the new chart package to the gh-pages branch  
- Update index file
```console
helm repo index . --url https://buxorg.github.io/bux-helm/
```
- Push changes to the repository