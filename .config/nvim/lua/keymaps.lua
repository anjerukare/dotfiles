-- Set leader key
vim.g.mapleader = ','

-- Easy quit from command-line
vim.keymap.set('c', ':', '<C-c>', { silent = true })

--- Colemak
-- Left, down, up, right
-- Note that 'g' is used for moving through wrapped line
vim.keymap.set({ 'n', 'x', 'o' }, 'm', 'h', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'n', 'gj', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'e', 'gk', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'i', 'l', { silent = true })

-- Insert and insert at beginning of line
vim.keymap.set('n', 't', 'i', { silent = true })
vim.keymap.set('n', 'T', 'I', { silent = true })

-- Till
vim.keymap.set({ 'n', 'v' }, 'l', 't', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'L', 'T', { silent = true })
-- Combinations
vim.keymap.set('n', 'cl', 'ct', { silent = true })
vim.keymap.set('n', 'dl', 'dt', { silent = true })
vim.keymap.set('n', 'vl', 'vt', { silent = true })
vim.keymap.set('n', 'yl', 'yt', { silent = true })

-- Semantic end of word, end of word
vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'e', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'K', 'E', { silent = true })

-- Open man page for the word under cursor
vim.keymap.set({ 'n', 'x', 'o' }, 'M', 'K', { silent = true })

-- Next match, previous match
vim.keymap.set({ 'n', 'x', 'o' }, 'h', 'n', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'H', 'N', { silent = true })

-- Mark
vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'm', { silent = true })

-- Page-down, page-up with cursor at top of page
vim.keymap.set({ 'n', 'x', 'o' }, '<C-n>', '<C-f>', { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<C-e>', '<C-b>H', { silent = true })

-- Window navigation
vim.keymap.set({ 'n', 'x' }, '<C-W>m', '<C-W>h', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-W>n', '<C-W>j', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-W>e', '<C-W>k', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-W>i', '<C-W>l', { silent = true })

-- Fix inner and till sequences
-- TODO Find the way to fix vi combination
vim.keymap.set('n', 'ci', 'ci', { silent = true })
vim.keymap.set('n', 'di', 'di', { silent = true })
vim.keymap.set('n', 'vi', 'vi', { silent = true })
vim.keymap.set('n', 'yi', 'yi', { silent = true })

-- Handy esc
vim.keymap.set('i', 'ii', '<Esc>', { silent = true })
