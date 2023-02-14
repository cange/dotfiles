# Dotfiles

These are basic configurations of my working environment like editor, shell and
terminal.

## Setup

The setups are focus on MacOS since this is my daily environment.

Clone of this repo on system user root:

```shell
git clone http://github.com/cange/dotfiles.git
```

### Install

Run install command to set up the appropriate symlinks:

```sh
dotfiles/cli install
```

### Uninstall

To remove related symlinks with:

```sh
dotfiles/cli uninstall
```

### Homebrew

This allows us to install tools and apps from the command line. Follow the
installation guide [Homebrew](https://brew.sh/).

This will also install the xcode build tools which is needed by many other
developer tools.
Install them in one go by placing them all into a text file and then running
brew install:

```sh
touch apps.txt && echo 'asdf firefox-developer-edition fork git git-delta gpg-suite iterm2 itsycal keepingyouawake neovim raycast stats' >> apps.txt
xargs brew install < apps.txt
rm apps.txt
```

### Terminal

The basic configuration and theme for _Iterm2_ can be found at
`~/dotfiles/iterm2`.

### Shell

Install _zsh_ plugins:

```sh
touch zsh_plugins.txt && echo 'zsh-async zsh-autosuggestions zsh-syntax-highlighting' >> zsh_plugins.txt
xargs brew install < zsh_plugins.txt
rm zsh_plugins.txt
```

It might be necessary to install [oh-my-zsh] because one or more plug-ins are
still being used.

[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh#basic-installation

### Editor

See _NeoVim_ set up [README](./nvim/README.md).

### Other Applications

The following is a list of apps and tools

| Application     | Description                       |
| --------------- | --------------------------------- |
| asdf            | Multiple runtime versions manager |
| fork            | fast and friendly git client      |
| gpg-suite       | protects Git commits              |
| iterm2          | terminal                          |
| itsycal         | menu bar calender                 |
| keepingyouawake | prevent Max from going to sleep   |
| neovim          | code editor                       |
| raycast         | advanced quick launcher           |
| stats           | menu bar system monitor           |
