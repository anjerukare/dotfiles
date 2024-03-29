-- Hide mode cuz it's done by lualine
vim.opt.showmode = false

-- Lualine setup
require('lualine').setup {
  options = {
    theme = require('lualine.themes.redhead'),
    section_separators = '',
    component_separators = '|',
    icons_enabled = false,
    disabled_filetypes = { 'nnn' }
  },
  sections = {
    lualine_b = {
      'branch',
      'diff',
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
    },
    lualine_c = {
      {
        'filename',
        symbols = {
          modified = '*',
          readonly = ' [readonly]'
        }
      }
    },
    lualine_x = {},
    lualine_y = {}
  }
}

