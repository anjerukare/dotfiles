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
