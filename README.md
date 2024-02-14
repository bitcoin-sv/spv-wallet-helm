# Bux Components Chart Repository

## Chart release proccess

- Update appVersion in Chart.yaml for each component with new image
- Update version in Chart.yaml for all components
- Package new chart
```console
helm package bux-helm
```
- Copy new chart package to it to gh-pages branch  
- Update index file
```console
helm repo index . --url https://buxorg.github.io/bux-helm/
```
- Push changes to repository

  