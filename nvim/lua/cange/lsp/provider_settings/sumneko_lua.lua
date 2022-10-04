-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt#sumneko_lua
return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = 'Disable', -- "Enable", "Auto", "Disable"
        await = true,
        paramName = 'Disable', -- "All", "Literal", "Disable"
        paramType = false,
        semicolon = 'Disable', -- "All", "SameLine", "Disable"
        setType = true,
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          -- custom globals
          'R',
          'P',
          'RELOAD',
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
          -- [vim.fn.datapath "config" .. "/lua"] = true,
          -- Make the server aware of Neovim runtime files
          -- [vim.api.nvim_get_runtime_file('', true)] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
