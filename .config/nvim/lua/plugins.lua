-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile'
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

return require('packer').startup(function(use)
  -- Help packer identify itself
  use 'wbthomason/packer.nvim'

  -- Utility and appearance plugins
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('plugins.treesitter') end
  }
  use {
    'luukvbaal/nnn.nvim',
    config = function() require 'plugins.nnn' end
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require 'plugins.telescope' end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use {
    'windwp/nvim-autopairs',
    config = function() require 'plugins.autopairs' end
  }
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require 'plugins.lualine' end
  }
  use {
    'nanozuki/tabby.nvim',
    config = function() require 'plugins.tabline' end
  }
  use {
    'tpope/vim-fugitive',
    config = function() require 'plugins.fugitive' end
  }
  use 'rktjmp/lush.nvim'
  use '~/.config/nvim/redhead'

  -- Languages & frameworks plugins
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-dap'
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require 'plugins.flutter-tools' end
  }
  use 'mfussenegger/nvim-jdtls'
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    config = function() require 'plugins.autocompletion' end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'L3MON4D3/LuaSnip',
    config = function() require 'plugins.snippets' end
  }
  use 'saadparwaiz1/cmp_luasnip'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
