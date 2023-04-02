-- Open new tab, open git status, go to unstaged files, open diffsplit for first file
local enter_to_stage = function(open_status_command)
  vim.cmd(([[
    tabnew
    %s
    normal gU
    normal dd
  ]]):format(open_status_command))
end

-- Set keymap for git staging
vim.keymap.set('n', '<leader>gs', function() enter_to_stage('Git') end, { silent = true })

vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>', { silent = true })
vim.keymap.set('n', '<leader>gl', '<cmd>tabnew<Bar>GcLog<CR>', { silent = true })

-- Open git diff in split or close window with 'fugitive' in buffer name if git diff opened
local toggle_diff = function(open_diff_command)
  local is_in_diff_mode = function(window)
    return vim.api.nvim_win_get_option(window, 'diff')
  end
  if is_in_diff_mode(0) then
    local current_buffer_name = vim.api.nvim_buf_get_name(0)
    local has_fugitive_prefix = function(string)
      string:find('fugitive://')
    end
    if has_fugitive_prefix(current_buffer_name) then
      vim.api.nvim_win_close(0, false)
    else
      local windows_handlers = vim.api.nvim_tabpage_list_wins(0)
      for _, window_handler in pairs(windows_handlers) do
        if is_in_diff_mode(window_handler) then
          vim.api.nvim_win_close(window_handler, false)
          return
        end
      end
    end
  else
    vim.cmd(open_diff_command)
  end
end

vim.keymap.set('n', '<leader>gd', function() toggle_diff('Gdiffsplit') end, { silent = true })

-- Fugitive shortcuts for yadm
-- https://github.com/ibhagwan/nvim-lua/blob/69ce9dc00566ea55ddf79b22ccbc303635dca2c7/lua/plugins/fugitive.lua#L29
local yadm_repo = '$HOME/.local/share/yadm/repo.git'

vim.cmd(([[
  function! YadmComplete(A, L, P) abort
    return fugitive#Complete(a:A, a:L, a:P, {'git_dir': expand("%s")})
  endfunction
]]):format(yadm_repo))

vim.cmd(([[
  command! -bang -nargs=? -range=-1 -complete=customlist,YadmComplete Yadm exe fugitive#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>, { 'git_dir': expand("%s") })
]]):format(yadm_repo))

local function fugitive_command(nargs, cmd_name, cmd_fugitive, cmd_comp)
  vim.api.nvim_create_user_command(cmd_name,
    function(t)
      local bufnr = vim.api.nvim_get_current_buf()
      local buf_git_dir = vim.b.git_dir
      vim.b.git_dir = vim.fn.expand(yadm_repo)
      vim.cmd(cmd_fugitive .. " " .. t.args)
      -- after the fugitive window switch we must explicitly
      -- use the buffer num to restore the original 'git_dir'
      vim.b[bufnr].git_dir = buf_git_dir
    end,
    {
      nargs = nargs,
      complete = cmd_comp and string.format("customlist,%s", cmd_comp) or nil,
    }
  )
end

fugitive_command("?", "Yit", "Git", "YadmComplete")
fugitive_command("*", "Yread", "Gread", "fugitive#ReadComplete")
fugitive_command("*", "Yedit", "Gedit", "fugitive#EditComplete")
fugitive_command("*", "Ywrite", "Gwrite", "fugitive#EditComplete")
fugitive_command("*", "Ydiffsplit", "Gdiffsplit", "fugitive#EditComplete")
fugitive_command("*", "Yhdiffsplit", "Ghdiffsplit", "fugitive#EditComplete")
fugitive_command("*", "Yvdiffsplit", "Gvdiffsplit", "fugitive#EditComplete")
fugitive_command(1, "YMove", "GMove", "fugitive#CompleteObject")
fugitive_command(1, "YRename", "GRename", "fugitive#RenameComplete")
fugitive_command(0, "YRemove", "GRemove")
fugitive_command(0, "YUnlink", "GUnlink")
fugitive_command(0, "YDelete", "GDelete")
fugitive_command(0, "YcLog", "GcLog")

-- Set keymap for Yadm staging
vim.keymap.set('n', '<leader>ys', function() enter_to_stage('Yadm') end, { silent = true })

vim.keymap.set('n', '<leader>yy', '<cmd>Yadm<CR>', { silent = true })
vim.keymap.set('n', '<leader>yl', '<cmd>tabnew<Bar>YcLog<CR>', { silent = true })

vim.keymap.set('n', '<leader>yd', function() toggle_diff('Ydiffsplit') end, { silent = true })
