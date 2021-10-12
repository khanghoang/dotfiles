# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# zplug install
# zplug load

source ~/.zplug/init.zsh

# Load the oh-my-zsh's library.
# zplug "oh-my-zsh"

zplug "agkozak/zsh-z"
zplug "hlissner/zsh-autopair"

# nicoulaj's moar completion files for zsh -- not sure why disabled.
zplug "zsh-users/zsh-completions"

# Syntax highlighting on the readline
zplug "zsh-users/zsh-syntax-highlighting"

# Utils functions for git
zplug "wfxr/forgit"

# history search
zplug "zsh-users/zsh-history-substring-search"

# suggestions
zplug "tarruda/zsh-autosuggestions"

# colors for all files!
zplug "trapd00r/zsh-syntax-highlighting-filetypes"

# dont set a theme, because pure does it all
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# vi mode for terminal
zplug "jeffreytse/zsh-vi-mode"

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf \

set -o vi

# lazy load nvm since it will take 1-2 seconds for nvm to fully loaded
nvm() {
  unset -f nvm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm "$@"
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# set default editor
export EDITOR=nvim
export VISUAL=nvim

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/local/bin/nvim"
export PATH="$PATH:$HOME/.rvm/bin"
# export PATH="$PATH:$HOME/Library/Python/2.7/bin"
export PATH="$PATH:$HOME/.local/bin"

# Use Git's default (reverse chronological) order, never automatically
# use topo-order for the commit graph
set commit-order = default

# Limit number of commits loaded by default to 1000
set main-options = -n 1000

# Don't show staged and unstaged changes in the main view
set show-changes = no

export PYENV_ROOT="$HOME/.pyenv" export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# load fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'
# fzf config move up/down by Ctrl-D/Ctrl-U
export FZF_DEFAULT_OPTS="--bind ctrl-n:down,ctrl-p:up"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

export DOTFILES=$HOME/.config/nvim

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

alias luamake=/home/khanghoang/lua-language-server/3rd/luamake/luamake

# Then, source plugins and add commands to $PATH
zplug load

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

