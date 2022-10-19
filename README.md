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

2. Run (make sure the Ruby is installed)

```shell
./dotfiles/install
```

3. Follow the NeoVim set up guide [./nvim/](./nvim/)

4. Done

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

## MacOS Setup

### Applications

The following is a list of apps and tools
| Application | Description   |
| ---         | ---           |
| alt-tab                     | tab switch with thumbnail preview |
| firefox-developer-edition   | preferred web browser  |
| fork                        | fast and friendly git client |
| gimp                        | image editor |
| git                         | latest version of git |
| gpg-suite                   | protects emails, files and sign Git commits |
| inkscape                    | vector editor |
| iterm2                      | advanced terminal |
| itsycal                     | menu bar calender |
| keepingyouawake             | prevent Max from going to sleep |
| neovim                      | code editor |
| raycast                     | advanced quick launcher |
| stats                       | menu bar system monitor |

#### Homebrew

This allows us to install tools and apps from the command line. Follow the
installation guide [Homebrew](https://brew.sh/).

This will also install the xcode build tools which is needed by many other
developer tools.
Install them in one go by placing them all into a text file and then running
brew install:

```sh
touch apps.txt && echo 'alt-tab firefox-developer-edition fork gimp git gpg-suite inkscape iterm2 itsycal keepingyouawake neovim raycast stats' >> apps.txt
xargs brew install < apps.txt
rm apps.txt
```

#### Iterm2

The basic configuration and theme can be found at `~/dotfiles/iterm2`.

### CLI tools

| Tool  | Description |
| ---   | ---         |
| [asdf]      | Multiple runtime versions manager |
| [oh-my-zsh] | zsh configuration framework       |

[asdf]: https://asdf-vm.com/guide/getting-starte.html
[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh#basic-installation

### ZSH Setup

Install zsh plugins:

```sh
touch zsh_plugins.txt && echo 'zsh-async zsh-autosuggestions zsh-syntax-highlighting' >> zsh_plugins.txt
xargs brew install < zsh_plugins.txt
rm zsh_plugins.txt
```
