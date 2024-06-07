#!/usr/bin/env bash

bump_version() {
  local version=$1
  local part=$2

  # Split the version into an array
  IFS='.' read -r -a version_parts <<< "$version"

  case $part in
    major)
      ((version_parts[0]++))
      version_parts[1]=0
      version_parts[2]=0
      ;;
    minor)
      ((version_parts[1]++))
      version_parts[2]=0
      ;;
    patch)
      ((version_parts[2]++))
      ;;
  esac

  echo "${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"
}



# Read the current version from the file
current_version=$(yq '.version' ./charts/spv-wallet-stack/Chart.yaml)
echo "Current version: $current_version"

# Determine which part of the version to bump
case $1 in
  major | -mj)
    version=$(bump_version "$current_version" major)
    ;;
  minor | -m)
    version=$(bump_version "$current_version" minor)
    ;;
  patch | -p | "")
    version=$(bump_version "$current_version" patch)
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 [major|minor|patch|-mj|-m|-p]"
    exit 1
    ;;
esac

# Output the new version
echo "New version: $version"

charts=$(find . -name 'Chart.yaml')

echo "Found following Chart files to update version"
echo "$charts"
chartNames=$(echo "$charts" | xargs -I {} yq '.name' {})

echo "Bumping versions"
echo "$charts" | xargs -I {} yq ".version=\"$version\"" -i {}

echo "Updating versions of the dependencies"
echo "$chartNames"

for chart in $charts; do
  for chartName in $chartNames; do
    yq "(.dependencies[] | select(.name == \"$chartName\").version) |=\"$version\"" -i "$chart"
  done
done
