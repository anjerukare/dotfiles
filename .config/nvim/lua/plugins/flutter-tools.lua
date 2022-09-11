local defaults = require('language-servers.defaults')

-- Flutter-tools setup
require('flutter-tools').setup {
  lsp = {
    capabilities = defaults.capabilities,
    on_attach = function()
      defaults.on_attach()
      -- Lighter color of widget guides
      vim.api.nvim_set_hl(0, 'FlutterWidgetGuides', { ctermfg = 239 })
    end,
    settings = {
      analysisExcludedFolders = {
        vim.fn.expand('~/snap/flutter/common/flutter')
      }
    }
  },
  widget_guides = {
    enabled = true
  }
}
