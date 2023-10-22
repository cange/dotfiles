return {
  init_options = {
    typescript = {
      -- fixes https://github.com/neovim/neovim/issues/20010
      tsdk = Cange.get_config("lsp.mason_packages_path") .. "/typescript-language-server/node_modules/typescript/lib",
    },
  },
}
