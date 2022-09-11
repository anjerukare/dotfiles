-- Use popup menu to show possible completions when there is one or more
-- matches, don't select matches - force user to do it
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Nvim cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item {
      behavior = cmp.SelectBehavior.Insert
    },
    ['<C-p>'] = cmp.mapping.select_prev_item {
      behavior = cmp.SelectBehavior.Insert
    },
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    },
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(_)
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    }
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  }),
  window = {
    completion = {
      border = 'single',
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
    },
    documentation = {
      border = 'single',
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
    }
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

