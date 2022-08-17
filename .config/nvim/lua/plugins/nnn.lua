-- Nnn setup
local builtin = require("nnn").builtin

require('nnn').setup {
  replace_netrw = 'picker',
  mappings = {
    { "<C-t>", builtin.open_in_tab },     -- open file(s) in tab
    { "<C-s>", builtin.open_in_split },   -- open file(s) in split
    { "<C-v>", builtin.open_in_vsplit }   -- open file(s) in vertsplit
  }
}

-- Keymaps
vim.keymap.set('t', '<leader>t', '<cmd>NnnPicker<CR>', { silent = true })
vim.keymap.set('n', '<leader>t', '<cmd>NnnPicker %:p:h<CR>', { silent = true })
