local defaults = require('language-servers.defaults')

local home_dir = vim.fn.expand('~')
local lsp_dir = home_dir .. '/.local/share/nvim/lsp'
function append_path(dir)
  vim.env.PATH = vim.env.PATH .. ':' .. dir
end

append_path(lsp_dir .. '/lemminx')
require('lspconfig').lemminx.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

require('lspconfig').emmet_ls.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}

append_path(lsp_dir .. '/sumnekolua/bin')
require('lspconfig').sumneko_lua.setup {
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
