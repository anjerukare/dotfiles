-- Hide mode cuz it's done by lualine
vim.opt.showmode = false

-- Lualine setup
local transpink = require('plugins.lualine.themes.transpink')

require('lualine').setup {
  options = {
    theme = transpink,
    section_separators = '',
    component_separators = '|',
    icons_enabled = false,
    disabled_filetypes = { 'NvimTree' }
  },
  sections = {
    lualine_b = {'branch', 'diff',
      {
        'diagnostics',
        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
        symbols = {error = " ", warn = " ", info = " ", hint = " "}
      }
    }
  }
}

