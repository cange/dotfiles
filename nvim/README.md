# NeoVim as Editor

The config is located in `dotfiles/nvim`.

## Initial Run

### Plugins

An update dialog pops up and will install all required plugins when running
NeoVim first time.

You might want to run `:Lazy install` if the dialog is not popping up.

### Languages Support

In order to enable languages features run `:Mason` (within NeoVim) to install
all related LSP, formatter and linter.

Restart NeoVim ensures that all changes are applied.

### Troubleshooting

> **Note** Run `:checkhealth` after installation.

See also [help docs](./doc/cange.txt) or `:help cange.txt` for more details.
