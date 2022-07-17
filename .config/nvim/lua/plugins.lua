-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "none" }
    end,
  },
}

return require('packer').startup(function(use)
  -- Help packer identify itself
  use 'wbthomason/packer.nvim'

  -- Utility and appearance plugins
  use { 'luukvbaal/nnn.nvim', config = require 'plugins.nnn' }
  use { 'windwp/nvim-autopairs', config = require 'plugins.autopairs' }
  use { 'numToStr/Comment.nvim', config = require('Comment').setup() }
  use { 'nvim-lualine/lualine.nvim', config = require 'plugins.lualine' }
  use { 'crispgm/nvim-tabline', config = require('tabline').setup {} }

  -- Languages & frameworks plugins
  use 'neovim/nvim-lspconfig'
  use 'dart-lang/dart-vim-plugin'
  use 'nvim-lua/plenary.nvim'
  use { 'akinsho/flutter-tools.nvim', config = require 'plugins.flutter-tools' }

  -- Autocompletion
  use { 'hrsh7th/nvim-cmp', config = require 'plugins.autocompletion' }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
