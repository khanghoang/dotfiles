# Dotfiles
Dear future me,  
It seems like you have problem with dotfiles again, don't you? No worry, we have it all the time.  
Here is the list of things that you need to do to save your time and productivity.  

## Alfred theme
https://www.alfredapp.com/extras/theme/wmXBE8FfEe/

## Fonts
https://www.dropbox.com/home/fonts

## [NEW] Follow this blog
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

## Install brew `z`
https://gist.github.com/mischah/8149239

## On old machine.
#### Give permission to `backup.sh`
```
chmod +x backup.sh
```

#### Every time you want to backup your dotfiles, run:
```
./backup.sh [message]
```

### Italic fonts in NeoVim
[https://github.com/indiesquidge/squidgefiles](https://github.com/indiesquidge/squidgefiles)
[https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/#tmux-21-and-above](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/#tmux-21-and-above)

## On new machine
#### Install [skwp dotfiles](https://github.com/skwp/dotfiles/)
#### 
If you get problem with <D-j> and <D-k>, remember to go to this file ` ~/.yadr/vim/settings/yadr-keymap-mac.vim` and then comment out these 2 lines.
```
 43. " autocmd FileType javascript map <buffer> <D-k> }
 44. " autocmd FileType javascript map <buffer> <D-j> {
```

#### Sit back and enjoy 🌮

## Pro mode
#### Moves like jagger
`Ctrl-D`/`Ctrl-U` move up and down page screen.

#### Jump/Navigate
`,,b`/`,,w` jump back and forth.

#### Faster Ack
`K` it will search with the text under the cursor

### List git history of a file
`:BCommits`

### Get all commands that available
`:Commands`

### Get mapped commands
`:Maps`  
  
  

# You Want This - but on Vim

![](https://pbs.twimg.com/media/CbhkLYVWAAAib0S.png) 

Read on to find out to how to get it.

## First

> Get [Operator Mono](http://www.typography.com/blog/introducing-operator) 


## Second

> 1. Create a file named ``xterm-256color-italic.terminfo`` in your home directory (or wherever)

> 2. Run the install (below) with ``tic``

```
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

xterm-256color-italic|xterm with 256 colors and italic,
	sitm=\E[3m, ritm=\E[23m,
	use=xterm-256color,
```
```
#
# Install:
#
#   tic xterm-256color-italic.terminfo
#
# Usage:
#
#   export TERM=xterm-256color-italic
#

```
## Third

> Change your iTerm terminal type to match the variable created above

![](https://s3.amazonaws.com/f.cl.ly/items/311t171X0H2b2a0q3X3z/Screen%20Shot%202016-07-19%20at%2012.45.27%20PM.png)

## Fourth

> Open up your init.vim/.vimrc and add the following

> (Note that you don't need to use OceanicNext, but I recommend that color scheme.)

```
    colorscheme OceanicNext
    hi htmlArg gui=italic
    hi Comment gui=italic
    hi Type    gui=italic
    hi htmlArg cterm=italic
    hi Comment cterm=italic
    hi Type    cterm=italic
``` 

# FAQ
## Git `save` and `continue`
```
save = !git add -A && git commit -m 'SAVEPOINT'
continue = reset HEAD~1
```
## Neovim: problem with python?
You need to install `pip` and then "connect" with neovim  
Install with `pip3 install neovim`  
Install `pip` with python2 by `sudo easy_install pip`  
https://github.com/tweekmonster/nvim-python-doctor/wiki/Advanced:-Using-pyenv  
http://www.pyladies.com/blog/Get-Your-Mac-Ready-for-Python-Programming/  

## Tmux enable mouse & clipboard copy
![preferences 2017-07-31 17-46-48](https://user-images.githubusercontent.com/3213579/28774569-3cab84c6-7618-11e7-91b7-ae1abcb3a263.png)

## Problem with vim or tmux yank?
Check `vim` `+clipboard` by `vim --version | grep clipboard`, if it's `-clipboard` then you may need to install `vim` from `brew install vim --override-system-vim`   
Install `brew install reattach-to-user-namespace` to make nvim yank work in tmux


