-- Yazi setup
require('yazi').setup {
  open_for_directories = true,
  floating_window_scaling_factor = 0.7,
  yazi_floating_window_border = 'single'
}

-- Keymaps
vim.keymap.set('n', '<leader>t', function()
  require('yazi').yazi()
end)
