-- Setup jdtls
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Disable snippets because they loads slow
capabilities.textDocument.completion.completionItem.snippetSupport = false;

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
    '-jar', '/opt/jdt-language-server-1.14.0-202207211651/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/opt/jdt-language-server-1.14.0-202207211651/config_linux',
    '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew',
    'pom.xml'}),
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
  capabilities = capabilities
}

-- Keymaps
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('x', '<leader>a', vim.lsp.buf.range_code_action, bufopts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

-- Show diagnostic float window on hover
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter",
        "FocusLost" },
      border = 'single',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- Auto fold imports
vim.bo.foldmethod = 'expr'
vim.cmd [[
  setlocal foldexpr=GetImportFold(v:lnum)
  function! GetImportFold(lnum)
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
]]
