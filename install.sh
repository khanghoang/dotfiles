#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew bundle
pip3 install neovim --upgrade

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# install zgen
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
