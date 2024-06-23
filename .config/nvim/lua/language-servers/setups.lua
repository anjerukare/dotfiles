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

require('lspconfig').docker_compose_language_service.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

require('lspconfig').kotlin_language_server.setup {
  capabilities = defaults.capabilities,
  on_attach = function()
    defaults.on_attach()
    vim.opt.tabstop = 4 -- how many columns use to display \t
    vim.opt.shiftwidth = 4 -- how many columns use per indent level
    vim.opt.softtabstop = 4 -- how many whitespaces add / remove then
                            -- <Tab> / <BS> is pressed
  end,
  init_options = {
    formatting = {
      maxWidth = 80
    }
  }
}

require('lspconfig').taplo.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

