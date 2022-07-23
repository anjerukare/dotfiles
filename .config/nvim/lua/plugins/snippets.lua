-- Luasnip setup
local luasnip = require('luasnip')

luasnip.config.setup {
  -- If snippet was exited, one can still be jump back into
  history = true,
  -- Update snippet body when typing
  updateevents = 'TextChanged,TextChangedI'
}
