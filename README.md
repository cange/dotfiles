# Dotfiles setting

This *dotfiles* contains the [bash-it](https://github.com/revans/bash-it) framework, which brings the following functionality: autocompletion, themes, aliases, custom functions.
Further based the vimbundle handling on [dotmatrix](https://github.com/hashrocket/dotmatrix).

## How to install dotfiles

1. Check a clone of this repo: `git clone http://github.com/cange/dotfiles.git ~/dotfiles`
2. Set up [Vundle]:
```shell
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

3. Run (make sure the Ruby is installed)
```shell
./dotfiles/install
```
4. Done

## How to update vim plugins?
Call the following in Vi or Vim (Vundle)
```vi
:PluginClean
```

### Set ZSH as default shell
Remove/backup all .bash\* files in your user root directory and set then
```shell
chsh -s /usr/bin/zsh
```
## Other useful tools

* [git-extras](https://github.com/visionmedia/git-extras/)
