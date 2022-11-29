local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = false
M.capabilities = require('cmp_nvim_lsp').update_capabilities(M.capabilities)

M.on_attach = function()
  -- Keymaps
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true })
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
  vim.keymap.set('x', '<leader>a', vim.lsp.buf.range_code_action,
    { silent = true })
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { silent = true })
  -- Set keymaps for moving to through diagnostics
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true })
  
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
  -- Set time that affects CursorHold event
  vim.opt.updatetime = 500
  
  -- Disable virtual-text of diagnostic messages
  vim.diagnostic.config({ virtual_text = false })

  -- Diagnostic signs
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Show sign of the highest severity
  local ns = vim.api.nvim_create_namespace("my_namespace")
  local orig_signs_handler = vim.diagnostic.handlers.signs
  vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
      -- Get all diagnostics from the whole buffer rather than just the
      -- diagnostics passed to the handler
      local diagnostics = vim.diagnostic.get(bufnr)

      -- Find the "worst" diagnostic per line
      local max_severity_per_line = {}
      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end

      -- Pass the filtered diagnostics (with our custom namespace) to
      -- the original handler
      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
      orig_signs_handler.hide(ns, bufnr)
    end,
  }

  -- Configuration for documentation float window
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'single', max_height = 16 }
  )
end

return M
