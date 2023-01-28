-- Set colorscheme
local colorscheme = 'redhead'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end

-- Disable underline in current line on DiffChange/DiffAdd
-- https://github.com/neovim/neovim/issues/9800#issuecomment-1101776120
vim.api.nvim_set_hl(0, 'CursorLine', { ctermfg = 0 })

