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
