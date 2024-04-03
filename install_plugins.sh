#!/usr/bin/env fish
#title         :install_plugins.sh
#description   :This script will install and configure themes and plugins for Fish Shell
#author        :BGoodatit
#date          :2024-04-03
#version       :1.2
#usage         :curl --silent --location "https://github.com/BGoodatit/iterm-fish-fisher-osx/blob/askthecode/install_plugins.sh?raw=true" | fish
#fish_version  :3.2.2
#===================================================================================

curl --silent --location https://git.io/fisher | source
brew install terminal-notifier grc

fisher install jorgebucaran/fisher
fisher install edc/bass
fisher install oh-my-fish/theme-chain
fisher install patrickf1/colored_man_pages.fish
fisher install franciscolourenco/done
fisher install oh-my-fish/plugin-grc
fisher install jorgebucaran/nvm.fish
fisher install oh-my-fish/plugin-pj
fisher install markcial/upto
fisher install patrickf1/fzf.fish
fisher install jethrokuan/z
fisher install jorgebucaran/fnm

# Adding OMF plugins
omf install bass
omf install fish-spec
omf install expand
omf install fish_logo
omf install vcs

set --universal --export theme_nerd_fonts yes
set --universal --export theme_color_scheme zenburn
set --universal --export PROJECT_PATHS ~/Library/Projects

fish_update_completions

