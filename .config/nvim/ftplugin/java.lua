-- Setup jdtls
local defaults = require('language-servers.defaults')
local jdtls_home = vim.fn.expand('~/.local/share/nvim/lsp/jdtls')
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

require('jdtls').start_or_attach {
  cmd = {
    '/usr/lib/jvm/java-17-openjdk-amd64/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    vim.fn.glob(jdtls_home .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', jdtls_home .. '/config_linux',
    '-data', vim.fn.expand('~/.cache/jdtls-workspaces/') .. workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew',
    'pom.xml'}),
  init_options = {
    bundles = {
      vim.fn.glob(jdtls_home .. '/bundles/com.microsoft.java.debug.plugin-*.jar')
    }
  },
  capabilities = defaults.capabilities,
  on_attach = function()
    defaults.on_attach()
    require('jdtls').setup_dap()
  end
}

-- Options
vim.opt.tabstop = 4 -- how many columns use to display \t
vim.opt.shiftwidth = 4 -- how many columns use per indent level
vim.opt.expandtab = true -- insert spaces then press <Tab>
vim.opt.softtabstop = 4 -- how many whitespaces add / remove then
                        -- <Tab> / <BS> is pressed

-- Debug configuration
require('dap').configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = 'Debug (Attach) - Remote';
    hostName = '127.0.0.1';
    port = 5005;
  }
}

-- Auto fold imports
vim.wo.foldmethod = 'expr'
vim.cmd [[
  setlocal foldexpr=GetFoldLevel(v:lnum)
  function! GetFoldLevel(lnum)
    let current_line = getline(a:lnum)
    " If current line starts with import and no matter how ends
    " then it's import to fold
    if current_line =~? '^import.*$'
      return '1'
    endif

    let prev_line = getline(a:lnum - 1)
    let next_line = getline(a:lnum + 1)
    " If current line is blank but previous and next lines are imports
    " then it's blank line for chaining imports block
    if current_line =~? '^$' && prev_line =~? '^import.*$' &&
        \ next_line =~? '^import.*$'
      return '1'
    endif

    return '0'
  endfunction

  setlocal foldtext=GetFoldText()
  function! GetFoldText()
    let fold_start = getline(v:foldstart)
    if fold_start =~? '^import.*$'
      return 'import ···'
    endif
    return foldtext()
  endfunction
]]
