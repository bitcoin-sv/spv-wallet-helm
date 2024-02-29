#!/usr/bin/env bash

charts=$(find . \
                \! -path "./charts/spv-wallet-stack/charts/spv-wallet-web/Chart.yaml" \
                \! -path "./charts/spv-wallet-stack/Chart.yaml" \
                -name 'Chart.yaml')

echo "Found following Chart files to update version"
echo "$charts"

for chart in $charts; do
  chartName=$(yq '.name' "$chart")
  currentVersion=$(yq '.appVersion' "$chart")
  echo "======================================"
  echo "Starting to update $chartName"
  echo "Current version of $chartName is $currentVersion"
  echo "Looking for new version of $chartName"
  latestVersion=$(gh release list -R "bitcoin-sv/$chartName" --json 'isLatest,tagName' --jq '.[] | select(.isLatest) | .tagName')
  if [ "$latestVersion" == "" ]; then
    echo "Couldn't find a release in bitcoin-sv/$chartName"
    continue
  fi
  echo "Latest version of $chartName is $latestVersion"
  if [ "$latestVersion" != "$currentVersion" ]; then
    echo "There is newer version of $chartName, updating to $latestVersion"
    yq ".appVersion=\"$latestVersion\"" -i "$chart"
  else
    echo "$chartName is already in latest version"
  fi

done
