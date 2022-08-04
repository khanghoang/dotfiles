# Dotfiles

## Stow to symlink configs

As a result, the .dotfiles directory will look like this:

```
.dotfiles
├── bash
│   └── .bashrc
├── vim
│   └── .vimrc
├── xdg_config
│   └── .config
└── git
    └── .gitconfig
```

Install `stow`
```
brew install stow
```
or
```
sudo apt-get install stow
```
In `dotfiles` dir, run (Keep in mind that operation must be completed)

```
stow --verbose --target=$HOME */
```

