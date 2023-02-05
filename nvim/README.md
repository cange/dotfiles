# NeoVim

## Installation

First install NeoVim itself:

```sh
brew install neovim
```

See also <https://neovim.io/>

### Configuration

The config is located in `dotfiles/nvim` and needs to symlink to the actual
OS directory.
Use the command below to achieve this:

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/"
```

This applies the config when open NeoVim again.

#### JavaScript Binaries

Ensure Node.js has been installed in order run dependency management via
"npm".

#### Other Binaries

Some plugins needs certain tools in order to work properly.

```sh
touch nvim-deps.txt && echo 'tree-sitter lua-language-server ripgrep font-fira-code-nerd-font wget deno' >> nvim-deps.txt
xargs brew install < nvim-deps.txt
rm nvim-deps.txt
```

The following packages are required to install in order to use this NeoVim
setup:

| What                | Usage                                 |
| :------------------ | :------------------------------------ |
| tree-sitter         | Syntax completion/diagnostic tooling  |
| lua-language-server | Syntax auto completion                |
| ripgrep             | Telescope needs it to search in files |
| nerd-fonts          | Font icons                            |
| wget                | required by LSP mason client          |
| deno                | required by peek markdow-previewer    |

#### Install JavaScript Binaries

Some functions require associated npm executable packages, which can be
installed as follows:

```sh
npm install --global typescript-language-server \
            @fsouza/prettierd \
            @johnnymorganz/stylua-bin \
            @volar/vue-language-server \
            eslint_d \
            jsonlint \
            stylelint \
            typescript
```

### First Start

#### Plugins

When runing NeoVim first time update dialog pops up and will install the
necessary plugins.

To apply the updated you might have to restart after this NeoVim.

> **Tip!** It is recommended to run `:checkhealth` after installation.

### Language Support (LSP)

After that run `:MasonInstallAll` in install support of all relevant languages
(LSP).

See also [help docs](./doc/cange.txt) or `:help cange.txt` for more details.
