-- Luasnip setup
local luasnip = require('luasnip')

luasnip.config.setup {
  -- If snippet was exited, one can still be jump back into
  history = true,
  -- Update snippet body when typing
  updateevents = 'TextChanged,TextChangedI'
}

vim.keymap.set('i', '<Tab>', function()
    if luasnip.expand_or_jumpable() then
      return '<Plug>luasnip-expand-or-jump'
    else
      return '<Tab>'
    end
  end,
  { silent = true, remap = true, expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function() luasnip.jump(-1) end,
  { silent = true })
vim.keymap.set('s', '<Tab>', function() luasnip.jump(1) end,
  { silent = true })
