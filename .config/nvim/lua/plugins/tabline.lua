-- Tabline setup
local tab = require('tabby.tab')

local hl_tabline = 'TabLine'
local hl_tabline_sel = 'TabLineSel'
local hl_tabline_fill = 'TabLineFill'

local function tab_label(tabid)
  local number = vim.api.nvim_tabpage_get_number(tabid)
  local name = tab.get_name(tabid)
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
