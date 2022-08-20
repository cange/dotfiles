# Dotfiles setting

This *dotfiles* contains the [bash-it](https://github.com/revans/bash-it)
framework, which brings the following functionality: autocompletion, themes,
aliases, custom functions.
Further based the vimbundle handling on
[dotmatrix](https://github.com/hashrocket/dotmatrix).

## How to install dotfiles

1. Check a clone of this repo:
```shell
git clone http://github.com/cange/dotfiles.git ~/dotfiles
```

2. Set up [vim-plug](https://github.com/junegunn/vim-plug):
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

3. Run (make sure the Ruby is installed)
```shell
./dotfiles/install
```
4. Done

## How to update vim plugins?
Call the following in Vi or Vim (Vundle)
```vi
:PlugClean
```

### ZSH Theme

Follow the installation to enable the defined theme `.zshrc` file:
<https://github.com/spaceship-prompt/spaceship-prompt#oh-my-zsh>


### Set ZSH as default shell
Remove/backup all .bash\* files in your user root directory and set then
```shell
chsh -s /usr/bin/zsh
```
## Other useful tools

* [git-extras](https://github.com/visionmedia/git-extras/)
