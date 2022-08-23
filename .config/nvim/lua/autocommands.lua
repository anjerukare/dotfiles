-- Disable spell check in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    command = 'setlocal nospell'
})
