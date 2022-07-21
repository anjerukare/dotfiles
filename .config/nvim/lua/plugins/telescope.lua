-- Telescope setup
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>',
  { silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>',
  { silent = true })
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', 
  { silent = true })

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-s>'] = actions.select_horizontal
      },
      n = {
        ['q'] = actions.close,
        ['n'] = actions.move_selection_next,
        ['e'] = actions.move_selection_previous,
        ['<C-s>'] = actions.select_horizontal
      }
    },
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
      results = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    prompt_prefix = ' ',
    selection_caret = ' ',
    entry_prefix = ' ',
    -- Trim indentation at the beginning in results
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim' -- add this value
    }
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      borderchars = {
        { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
        results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      },
      previewer = false,
      prompt_title = false
    }
  },
  extensions = {
    ['ui-select'] = {
      -- Use get_cursor theme
      -- TODO Set it only to code actions
      require('telescope.themes').get_cursor({
        borderchars = {
          { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
          prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
          results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
          preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        },
        layout_config = {
          width = 50
        }
      })
    }
  }
}

-- Highlights
vim.cmd 'highlight! link TelescopeBorder FloatBorder'
vim.cmd 'highlight! link TelescopeTitle Normal'

--- Extensions
-- Fzf sorter for telescope
require('telescope').load_extension('fzf')
-- Set vim.ui.select to telescope
require('telescope').load_extension('ui-select')
