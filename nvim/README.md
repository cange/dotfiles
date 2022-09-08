# NeoVim

## Installation

Link the `nvim` config directory to enable the configurations in NeoVim setup.

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

#### Binaries

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

#### JavaScript

This binaries are needed to enables auto completion, diagnostics and fromatting
for the language.

```sh
npm i -g typescript-language-server typescript @fsouza/prettierd eslint_d
```

> LSP, null-ls, treesitter

<https://github.com/typescript-language-server/typescript-language-server#installing>
