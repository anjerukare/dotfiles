local defaults = require('language-servers.defaults')

require('lspconfig').lemminx.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

require('lspconfig').emmet_ls.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

require('lspconfig').lua_ls.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
