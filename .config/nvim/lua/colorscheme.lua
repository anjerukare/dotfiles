-- Set colorscheme
local colorscheme = 'sunbather'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end

--- Extension of set colorscheme
-- Relink several highlight groups
vim.cmd 'highlight! link Typedef Keyword'
vim.cmd 'highlight! link StorageClass Keyword'

-- Transparent bg
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermfg = 251 })
-- Transparent bg of floating windows
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

-- Spelling highlight overwrite
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, fg = 'none',
  sp = '#767676' })
vim.cmd 'highlight! link SpellCap SpellBad'
vim.cmd 'highlight! link SpellRare SpellBad'
vim.cmd 'highlight! link SpellLocal SpellBad'

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
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true,
  sp = '#d75f87' })

vim.api.nvim_set_hl(0, 'DiagnosticInfo', { ctermfg = 243 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true,
  sp = '#767676' })

vim.api.nvim_set_hl(0, 'DiagnosticHint', { ctermfg = 243 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true,
  sp = '#767676' })

vim.api.nvim_set_hl(0, 'DiagnosticWarn', { ctermfg = 243 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true,
  sp = '#767676' })
