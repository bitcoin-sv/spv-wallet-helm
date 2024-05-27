#!/usr/bin/env bash

./verify_install_update_tools.sh

./update-apps.sh
anyUpdates=$(git status | grep -c 'Chart.yaml')
if [[ $anyUpdates -gt 0 ]]; then
  ./bump-chart-versions.sh
fi
