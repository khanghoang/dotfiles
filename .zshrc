# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then

  # Load the oh-my-zsh's library.
  zgen oh-my-zsh

  zgen load z
  zgen load hlissner/zsh-autopair

  # nicoulaj's moar completion files for zsh -- not sure why disabled.
  # zgen load zsh-users/zsh-completions src

  # Syntax highlighting on the readline
  zgen load zsh-users/zsh-syntax-highlighting

  # Utils functions for git
  zgen load wfxr/forgit

  # history search
  zgen load zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

  # suggestions
  zgen load tarruda/zsh-autosuggestions

  # colors for all files!
  zgen load trapd00r/zsh-syntax-highlighting-filetypes

  # dont set a theme, because pure does it all
  zgen load mafredri/zsh-async
  zgen load sindresorhus/pure

  # notify for long running commands
  zgen load marzocchi/zsh-notify

  # Tell Antigen that you're done.
  zgen save

fi

set -o vi

# lazy load nvm since it will take 1-2 seconds for nvm to fully loaded
nvm() {
  unset -f nvm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm "$@"
}

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# set default editor
export EDITOR=nvim
export VISUAL=nvim

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/Library/Python/2.7/bin"

# fzf config move up/down by Ctrl-D/Ctrl-U
export FZF_DEFAULT_OPTS='--bind ctrl-d:down,ctrl-u:up'

# Recent git branches
alias grb='git branch --sort=-committerdate | fzf | xargs git checkout'

# https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh/292660#292660
export DISABLE_AUTO_TITLE="true"

alias vi='nvim'
alias cat='bat'

# change the color of auto-suggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
  # Load rupa's z if installed
  [ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi
