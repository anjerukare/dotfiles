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

-- copied from .ghcup/env
append_path(home_dir .. '/.cabal/bin')
append_path(home_dir .. '/.ghcup/bin')
require('lspconfig').hls.setup {
  capabilities = defaults.capabilities,
  on_attach = defaults.on_attach
}
