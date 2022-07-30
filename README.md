# Dotfiles

## Stow to symlink configs

Install `stow`
```
brew install stow
```
or
```
sudo apt-get install stow
```
In `dotfiles` dir, run

```
stow --verbose --target=$HOME */
```

