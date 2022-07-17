-- Set colorscheme
local colorscheme = 'sunbather'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end

--- Extension of set colorscheme
-- Transparent bg
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- Transparent bg of floating windows
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

-- Spelling highlight overwrite
-- When Neovim will be updated to 0.9 it likely will have guisp key in
-- vim.api.nvim_set_hl (but not now on 7.0)
-- * then vim.highlight.create will be deleted
-- * use vim.api.nvim_set_hl instead
vim.highlight.create('SpellBad', { cterm = 'undercurl', ctermfg = 'none',
  guisp = '#767676' })
vim.highlight.create('SpellCap', { cterm = 'undercurl', ctermfg = 'none',
  guisp = '#767676' })
vim.highlight.create('SpellRare', { cterm = 'undercurl', ctermfg = 'none',
  guisp = '#767676' })
vim.highlight.create('SpellLocal', { cterm = 'undercurl', ctermfg = 'none',
  guisp = '#767676' })

-- Cursor line
vim.api.nvim_set_hl(0, 'CursorLine', {})
vim.api.nvim_set_hl(0, 'CursorLineNr', { cterm = {}, ctermbg = 'none',
  ctermfg = 168 })

-- Thin window separator
vim.api.nvim_set_hl(0, 'VertSplit', { ctermfg = 233, ctermbg = 'none' })
-- fg to 'none' not working, probably bug
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none', fg = 0 })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none' })

-- Tabline
vim.api.nvim_set_hl(0, 'TabLine', { ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'TabLineSel', { cterm = {}, ctermfg = 168,
  ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'TabLineFill', { ctermbg = 'none' })

-- Diagnostic colors
vim.api.nvim_set_hl(0, 'DiagnosticError', { ctermfg = 168 })
vim.highlight.create('DiagnosticUnderlineError', { cterm = 'undercurl',
  guisp = '#d75f87' })

vim.api.nvim_set_hl(0, 'DiagnosticInfo', { ctermfg = 243 })
vim.highlight.create('DiagnosticUnderlineInfo', { cterm = 'undercurl',
  guisp = '#767676' })

vim.api.nvim_set_hl(0, 'DiagnosticHint', { ctermfg = 243 })
vim.highlight.create('DiagnosticUnderlineHint', { cterm = 'undercurl',
  guisp = '#767676' })

vim.api.nvim_set_hl(0, 'DiagnosticWarn', { ctermfg = 243 })
vim.highlight.create('DiagnosticUnderlineWarn', { cterm = 'undercurl',
  guisp = '#767676' })
