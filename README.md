# Dotfiles

These are basic configurations of my working environment of things like editor,
shell and terminal configurations.

## Setup

The setups are focus on MacOS since this is my daily environment.

Clone of this repo on system user root:

```shell
git clone http://github.com/cange/dotfiles.git
```

### Installation

Once the repo has been cloned, the required dependencies can be installed using
[Homebrew](https://brew.sh/). To do this, navigate to the root of the repo and
run the following command:

```sh
brew bundle install
```

This will install any necessary dependencies defined in the `Brewfile`.

Finally, to set up the symlinks to apply all settings. Navigate to the root of
the repo and run the following command:

```sh
bootstrap link # or `unlink` to remove symlinks
```

### Symlinks

Each application/tool has its own config directory. Inside of these directories
can be a `symlinks.prop` file with a mapping. These files are evaluated during
the `bootstrap ...` call.

#### Secrets

User details such as tokens are stored in `$HOME/config/secrets/` individually.

## NeoVim as Editor

The config is located in `dotfiles/nvim`.

#### First Start

##### Plugins

An update dialog pops up and will install all required plugins when running
NeoVim first time.

Run`:Lazy install` (within NeoVim) if the dialog is not popping up.

##### Language Support (LSP)

Run `:MasonInstallAll` (within NeoVim) to install all related  LSP helpers.

To apply all updates you might need to restart NeoVim.

#### Troubleshooting

> Run `:checkhealth` after installation.

See also [help docs](./doc/cange.txt) or `:help cange.txt` for more details.

In the case of missing node packages, run the following command:

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
