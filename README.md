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
In `dotfiles` dir, run (Keep in mind that operation must be completed)

```
stow --verbose --target=$HOME */
```

