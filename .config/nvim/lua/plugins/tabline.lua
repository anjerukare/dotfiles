-- Tabline setup
local tab = require('tabby.tab')
local win = require('tabby.win')

local hl_tabline = 'TabLine'
local hl_tabline_sel = 'TabLineSel'
local hl_tabline_fill = 'TabLineFill'

local function get_name(tabid)
  local wins = win.all_in_tab(tabid)
  local focus_win = tab.get_current_win(tabid)
  local name = ''
  if vim.api.nvim_win_get_config(focus_win).relative ~= '' then
    name = '[Floating]'
  else
    name = win.get_bufname(focus_win)
  end
  if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(focus_win),
    'modified') then
    name = string.format('%s*', name)
  end
  if #wins > 1 then
    name = string.format('%s +', name)
  end
  return name
end

local function tab_label(tabid)
  local number = vim.api.nvim_tabpage_get_number(tabid)
  local name = get_name(tabid)
  return string.format('  %d] %s ', number, name)
end

require('tabby').setup {
  tabline = {
    hl = hl_tabline_fill,
    layout = 'tab_only',
    head = { { '  ' } },
    active_tab = {
      label = function(tabid)
        return {
          tab_label(tabid),
          hl = hl_tabline_sel,
        }
      end,
      left_sep = { '' },
      right_sep = { '' },
    },
    inactive_tab = {
      label = function(tabid)
        return {
          tab_label(tabid),
          hl = hl_tabline,
        }
      end,
      left_sep = { '' },
      right_sep = { '' },
    }
  }
}
