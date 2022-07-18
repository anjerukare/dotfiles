-- Telescope setup
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
  }
}

-- Extensions
require('telescope').load_extension('fzf')
