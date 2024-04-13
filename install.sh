#!/usr/bin/env bash
#title         :install.sh
#description   :This script will install and configure Fish Shell + Fisher
#author        :BGoodatit
#date          :2024-04-03
#version       :1.1
#usage         :bash <(curl --silent --location "https://github.com/BGoodatit/iterm-fish-fisher-osx/blob/askthecode/install.sh?raw=true")
#bash_version  :5.0.17(1)-release
#===================================================================================

set -ueo pipefail

# Setting PATH for Apple Silicon MacBooks
PATH=/opt/homebrew/bin:$PATH
TEMP_DIR=$(mktemp -d)
COLOR_SCHEME_URL="https://github.com/chriskempson/base16-iterm2/blob/master/base16-londontube.dark.256.itermcolors?raw=true"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/blob/bc4416e176d4ac2092345efd7bcb4abef9d6411e/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf?raw=true"
PLUGINS_INSTALLER_URL="https://github.com/BGoodatit/iterm-fish-fisher-osx/blob/askthecode/install_plugins.sh?raw=true"

INFO_LEVEL="\033[0;33m"
SUCCESS_LEVEL="\033[0;32m"

function print() {
  echo -e "$1$2\033[0m"
}

function print_banner() {
  print "$INFO_LEVEL" "                                               "
  print "$INFO_LEVEL" "   ____ _ ____ _  _ ____ _  _ ____ _    _      "
  print "$INFO_LEVEL" "   |___ | [__  |__| [__  |__| |___ |    |      "
  print "$INFO_LEVEL" "   |    | ___] |  | ___] |  | |___ |___ |___   "
  print "$INFO_LEVEL" "                                               "
  print "$INFO_LEVEL" "    Command Line Tools + Homebrew + iTerm2     "
  print "$INFO_LEVEL" "         + Fish Shell + Fisher + Plugins       "
  print "$INFO_LEVEL" "                 Optimized for Apple Silicon                  "
  print "$INFO_LEVEL" "                                               "
}

function install_command_line_tools() {
  if xcode-select --print-path &>/dev/null; then
    print "$SUCCESS_LEVEL" "Command Line Tools already installed, skipping..."
  else
    print "$INFO_LEVEL" "Installing Command Line Tools for Apple Silicon MacBooks..."

    xcode-select --install &>/dev/null
    until xcode-select --print-path &>/dev/null; do
      sleep 5
    done
  fi
}

function install_homebrew() {
  if which brew &>/dev/null; then
    print "$SUCCESS_LEVEL" "Homebrew already installed, skipping..."
  else
    print "$INFO_LEVEL" "Installing Homebrew specifically for Apple Silicon MacBooks..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

function install_iterm() {
  if [[ -d /Applications/iTerm.app ]]; then
    print "$SUCCESS_LEVEL" "iTerm 2 already installed, skipping..."
  else
    print "$INFO_LEVEL" "Installing iTerm 2 optimized for Apple Silicon MacBooks..."
    brew install --cask iterm2
  fi
}

function install_fish_shell() {
  if which fish &>/dev/null; then
    print "$SUCCESS_LEVEL" "Fish Shell already installed, skipping..."
  else
    print "$INFO_LEVEL" "Installing Fish Shell..."
    brew install fish
    command -v fish | sudo tee -a /etc/shells
    chsh -s "$(command -v fish)"
  fi
}

function install_fisher_and_plugins() {
  print "$INFO_LEVEL" "Installing Fisher + Plugins and post-processing installation..."
  PLUGINS_INSTALLER_PATH="$TEMP_DIR/install_plugins.sh"
  curl --silent --location --output "$PLUGINS_INSTALLER_PATH" "$PLUGINS_INSTALLER_URL"
  fish "$PLUGINS_INSTALLER_PATH"
}

function print_post_installation() {
  print "$SUCCESS_LEVEL" "                 "
  print "$SUCCESS_LEVEL" "!!! IMPORTANT !!!"
  print "$SUCCESS_LEVEL" "                 "

  print "$SUCCESS_LEVEL" "The script accomplished all the commands it was told to do"
  print "$SUCCESS_LEVEL" "Some things can't be automated and you need to do them manually"
  print "$SUCCESS_LEVEL" " "
  print "$SUCCESS_LEVEL" "1) Open iTerm -> Preferences -> Profiles -> Colors and apply Material Design preset"
  print "$SUCCESS_LEVEL" "2) Open iTerm -> Preferences -> Profiles -> Text and apply FiraCode Nerd Font with ligatures checkbox ticked"
  print "$SUCCESS_LEVEL" "3) Enjoy your new terminal environment optimized for Apple Silicon MacBooks"
}

print_banner

install_command_line_tools
install_homebrew
install_iterm
install_fish_shell
install_fisher_and_plugins

print_post_installation

  print "$SUCCESS_LEVEL" "The script accomplished all the commands it was told to do"
  print "$SUCCESS_LEVEL" "Unfortunately, some things can’t be automated and you need to do them manually"
  print "$SUCCESS_LEVEL" " "
  print "$SUCCESS_LEVEL" "1) Open iTerm -> Preferences -> Profiles -> Colors -> Color Presets and apply base16-londontube.dark preset"
  print "$SUCCESS_LEVEL" "2) Open iTerm -> Preferences -> Profiles -> Text -> Font and apply Hack Nerd Font with ligatures checkbox ticked"
  print "$SUCCESS_LEVEL" "3) Open iTerm -> Preferences -> Profiles -> Text -> Use a different font for non-ASCII text and apply FiraCode Nerd Font with ligatures checkbox ticked"
}

print_banner

install_command_line_tools
install_homebrew
install_iterm
install_iterm_color_scheme
install_iterm_nerd_fonts
install_fish_shell
install_fisher_and_plugins

print_post_installation
