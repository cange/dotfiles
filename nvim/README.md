# NeoVim

## Installation

First install NeoVim itself:

```sh
brew install neovim
```

See also <https://neovim.io/>

### NeoVim Configuration

The config is located in `dotfiles/nvim` and needs to symlink to the  actual
OS direcotry.
Use the command below to achieve this:

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/"
```

The configuration should now be applied to when open NeoVim again.

### Requriements

#### Package manager for Neovim

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

<https://github.com/wbthomason/packer.nvim>

#### JavaScript Binaries

Ensure [Node.js] has been installed in order run dependency management via
"npm".

[Node.js]: https://nodejs.org

#### Other Binaries

Some plugins needs certain tools in order to work properly.

```sh
touch nvim-deps.txt && echo 'tree-sitter lua-language-server ripgrep font-hack-nerd-font wget' >> nvim-deps.txt
xargs brew install < nvim-deps.txt
rm nvim-deps.txt
```

The following packages are required to install in order to use this NeoVim setup:

| What| Usage |
|:---|:---|
| [tree-sitter]         | Syntax completion/diagnostic tooling  |
| [lua-language-server] | Syntax auto completion                |
| [ripgrep]             | Telescope needs it to search in files |
| [nerd-fonts]          | Font icons                            |
| wget                  | required by LSP mason client          |

[tree-sitter]: https://github.com/tree-sitter/tree-sitter
[lua-language-server]: https://github.com/sumneko/lua-language-server
[ripgrep]: https://github.com/BurntSushi/ripgrep#installation
[nerd-fonts]: https://github.com/ryanoasis/nerd-fonts

#### Install JavaScript Binaries

The following npm packages needs to install in order to enable syntax
diagnostics and formatting:

```sh
npm install --global typescript-language-server \
typescript \
@fsouza/prettierd \
eslint_d \
jsonlint \
@johnnymorganz/stylua-bin
```

### First Start

Open neovim and run package manager

```vim
:PackerInstall
```

**Note:** You might run it more the once if some packages fail to install on
the first run.
