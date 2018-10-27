#!/usr/bin/env bash

# This script installs the stuff I use:  
# 
# Homebrew (if needed)
# minimal xcode
#
# tools via brew
# apps using brew-cask
#
# inspired by: https://hackernoon.com/personal-macos-workspace-setup-adf61869cd79
# and by: https://gist.github.com/codeinthehole/26b37efa67041e1307db
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Lastpass (website)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.

set -e

echo "Starting bootstrapping"

# xcode cmd-line tools (but you probably do this manually, to get git, to get this file)
echo "would install xcode cmd-line here"
# ENABLE ONCE! xcode-select --install

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Define taps!
declare -a taps=(
  'caskroom/cask'
  'caskroom/versions'
  'homebrew/bundle'
  'homebrew/core'
)

for tap in "${taps[@]}"; do
  brew tap "$tap"
done

# Update Homebrew
brew upgrade && brew update

## Now, tools I use...
PACKAGES=(
    npm
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

# echo "Installing cask..."
# brew install caskroom/cask

## Now, apps using cask

CASKS=(
  google-chrome
  firefox
  intellij-idea
  evernote
  docker
  slack
  iterm2
)

brew cask install ${CASKS[@]}

# check things out
brew doctor

echo "Bootstrapping complete"

