# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/khanghoang/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

alias vi=nvim

source ~/antigen.zsh

local b="antigen bundle"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# homebrew  - autocomplete on `brew install`
antigen bundle brew
antigen bundle brew-cask

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle nvm
antigen bundle npm
antigen bundle nvm
antigen bundle command-not-found
antigen bundle robbyrussell/oh-my-zsh plugins/z

# nicoulaj's moar completion files for zsh -- not sure why disabled.
# antigen bundle zsh-users/zsh-completions src

# Syntax highlighting on the readline
antigen bundle zsh-users/zsh-syntax-highlighting

# history search
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# suggestions
antigen bundle tarruda/zsh-autosuggestions

# colors for all files!
antigen bundle trapd00r/zsh-syntax-highlighting-filetypes

# dont set a theme, because pure does it all
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/khanghoang/code/gittag/packages/election-app/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/khanghoang/code/gittag/packages/election-app/node_modules/tabtab/.completions/electron-forge.zsh

# set Vim mode for bash
set -o vi

# fzf config move up/down by Ctrl-D/Ctrl-U
export FZF_DEFAULT_OPTS='--bind ctrl-d:down,ctrl-u:up'

export EDITOR=nvim
export VISUAL=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Customize to your needs...
# for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/Library/Python/2.7/bin"

# fzf config move up/down by Ctrl-D/Ctrl-U
export FZF_DEFAULT_OPTS='--bind ctrl-d:down,ctrl-u:up'

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
