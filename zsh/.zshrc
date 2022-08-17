# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # git
  # dotenv
  # urltools
  # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  # zsh-autosuggestions
  # git clone git@github.com:skywind3000/z.lua.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua
  # eval "$(lua ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua/z.lua --init zsh enhanced once fzf)"
  # z.lua
  # git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
  # zsh-vi-mode

  # always put this plugin last
  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  # zsh-syntax-highlighting
)

# If have problem with fzf Ctrl-r
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ~/.fzf/install

# enable z.lua
# brew install lua
# eval "$(lua ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua/z.lua --init zsh enhanced once fzf)"

# Doing initialization at the plugin sourcing (Instantly)
# fix conflict key binding with fzf
# https://github.com/jeffreytse/zsh-vi-mode/issues/24#issuecomment-873164478
# https://github.com/jeffreytse/zsh-vi-mode/issues/113#issue-935789567
#
# TLDR: Need to source zsh-vi-mode before oh-my-zsh
ZVM_INIT_MODE=sourcing
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Bind up and down keys
# zmodload -F zsh/terminfo +p:terminfo
# if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
#   bindkey ${terminfo[kcuu1]} history-substring-search-up
#   bindkey ${terminfo[kcud1]} history-substring-search-down
# fi

# bindkey '^P' history-substring-search-up
# bindkey '^N' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
  export FZF_DEFAULT_OPTS="--bind ctrl-n:down,ctrl-p:up"
fi

# lazy load nvm since it will take 1-2 seconds for nvm to fully loaded
nvm() {
  unset -f nvm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm "$@"
}

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

# export PYENV_ROOT="$HOME/.pyenv" export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.zsh_history
export HISTSIZE=1000   # the number of items for the internal history list
export SAVEHIST=1000   # maximum number of items for the history file

export DOTFILES=$HOME/.config/nvim

# The meaning of these options can be found in man page of `zshoptions`.
# setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
# setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
# setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
# setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
# setopt EXTENDED_HISTORY  # record command start time

alias luamake=/home/khanghoang/lua-language-server/3rd/luamake/luamake
export PATH="$PATH:$(yarn global bin)"

# setup for https://github.com/mickael-menu/zk-nvim
export ZK_NOTEBOOK_DIR=$HOME/thoughts/brain/
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin/zk"
# export NODE_OPTIONS="--max-old-space-size=4096"

# Go path
export PATH="$PATH:$HOME/go/bin/bin"
export TZ_LIST="Antarctica/Macquarie; Asia/Ho_Chi_Minh"

# deno
export DENO_INSTALL="/home/khanghoang/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

alias luamake=/home/khanghoang/code/lua-language-server/3rd/luamake/luamake
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# Aliases
alias vi=nvim
alias cat=bat

if [ -e /home/khanghoang/.nix-profile/etc/profile.d/nix.sh ]; then . /home/khanghoang/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# https://github.com/ohmyzsh/ohmyzsh/issues/9576#issuecomment-983233425
export GIT_TRACE=0
