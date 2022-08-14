# NeoVim

## Installation

Link the `nvim` config directory to enable the configurations in NeoVim setup.

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/"
```

The configuration should now be applied to when open NeoVim again.

### Requriements

#### Syntax completion/disagnotic tooling

The following packages are required to install in order to use this NeoVim setup:

```sh
brew install tree-sitter
```

<https://github.com/tree-sitter/tree-sitter>


```sh
brew install lua-language-server
```

<https://github.com/sumneko/lua-language-server>


```sh 
npm install -g typescript-language-server typescript
```

<https://github.com/typescript-language-server/typescript-language-server#installing>

#### Basic icons

```sh
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

<https://github.com/ryanoasis/nerd-fonts>


#### Package manager for Neovim

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

<https://github.com/wbthomason/packer.nvim>
