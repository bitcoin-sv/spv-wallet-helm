#!/bin/bash

check_and_install() {
  TOOL=$1
  INSTALL_CMD=$2

  if ! command -v "$TOOL" &> /dev/null; then
    echo "$TOOL is not installed. Installing..."
    eval "$INSTALL_CMD"
    if [[ $TOOL == "gh" ]]; then
      gh auth login
    fi
  else
    echo "$TOOL is already installed."
  fi
}

# Checking the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  if command -v apt-get &> /dev/null; then
    check_and_install "yq" "sudo apt-get update && sudo apt-get install -y yq"
    check_and_install "gh" "sudo apt-get update && sudo apt-get install -y gh"
  elif command -v yum &> /dev/null; then
    check_and_install "yq" "sudo yum install -y epel-release && sudo yum install -y yq"
    check_and_install "gh" "sudo yum install -y gh"
  elif command -v pacman &> /dev/null; then
    check_and_install "yq" "sudo pacman -S --noconfirm yq"
    check_and_install "gh" "sudo pacman -S --noconfirm github-cli"
  else
    echo "Unknown package manager. Please install yq and gh manually."
    exit 1
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if command -v brew &> /dev/null; then
    check_and_install "yq" "brew install yq"
    check_and_install "gh" "brew install gh"
  else
    echo "Homebrew is not installed. Please install Homebrew, yq, and gh manually."
    exit 1
  fi
else
  echo "Unknown operating system. Please install yq and gh manually."
  exit 1
fi
