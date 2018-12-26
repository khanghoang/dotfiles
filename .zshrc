# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/Library/Python/2.7/bin"

alias 'zalora'='cd ~/Documents/zalora'
alias 'sandbox'='cd ~/Documents/sandbox'
alias 'pets'='cd ~/Documents/petProjects'
alias 'md'='open -a /Applications/MacDown.app'
alias 'st'='open -a /Applications/SourceTree.app'
alias 'gif'='givegif'
alias 'gs'='git status -s'
alias 'gc'='git commit'
alias 'rn'='react-native'
alias 'fck'='tldr'
source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen bundle zsh-users/zsh-autosuggestions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# vim mode in bash
set -o vi

function f_notifyme {
  LAST_EXIT_CODE=$?
  CMD=$(fc -ln -1)
  # No point in waiting for the command to complete
  notifyme "$cmd" "$last_exit_code" &
}

export ps1='$(f_notifyme)'$ps1}

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh/292660#292660
DISABLE_AUTO_TITLE="true"

alias vi='nvim'
alias cat='bat'

alias config='/usr/bin/git --git-dir=/Users/khoangtrieu/.cfg/ --work-tree=/Users/khoangtrieu'
alias config='/usr/bin/git --git-dir=/Users/khoangtrieu/.cfg/ --work-tree=/Users/khoangtrieu'

export PATH=$PATH:/Users/khoangtrieu/opensource/depot_tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
  # Load rupa's z if installed
  [ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi
