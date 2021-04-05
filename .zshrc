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

  # vi mode for terminal
  zgen load jeffreytse/zsh-vi-mode

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
grb() {
  local tags branches target
  branches=$(
    git --no-pager branch --sort=-committerdate --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh/292660#292660
export DISABLE_AUTO_TITLE="true"

alias vi='nvim'
alias cat='bat'
alias lc='leetcode'

# change the color of auto-suggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
  # Load rupa's z if installed
  [ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

function run() {
  local scripts=$(cat package.json | python -c 'import sys, json; print "\n".join(sorted(["\t".join(s) for s in json.load(sys.stdin)["scripts"].items()]))')
  local script=$(echo "$scripts" | column -t -s $'\t' | fzf --height 50% --reverse --min-height 20 | awk '{print $1}')
  
  [ -n "$script" ]] && npm run $script
}

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/khanghoang/.config/yarn/global/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/khanghoang/.config/yarn/global/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh###-begin-leetcode-completions-###
#
# yargs command completion script
#
# Installation: /usr/local/bin/leetcode completion >> ~/.bashrc
#    or /usr/local/bin/leetcode completion >> ~/.bash_profile on OSX.
#
_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=("${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=$(/usr/local/bin/leetcode --get-yargs-completions "${args[@]}")

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
    fi

    return 0
}
complete -F _yargs_completions leetcode
###-end-leetcode-completions-###

