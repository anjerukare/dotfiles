-- Text
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- don't ignore case then search pattern contains
                         -- upper case character
vim.opt.smartindent = true -- right indent for {, }, #

-- General settings
vim.opt.confirm = true -- then buffer is changed and :q or :e is used,
                       -- raise confirm dialog instead of failing
vim.opt.undofile = true -- save undo history of file then saving
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.number = true -- show line numbers
vim.opt.cursorline = true -- highlight cursor line
vim.opt.signcolumn = 'number' -- show signs instead of line number
vim.opt.fcs = 'eob: ' -- hide ~'s at end of buffer
vim.opt.showtabline = 2 -- show tabline always
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu

-- Spelling
vim.opt.spell = true -- enable spell checking
vim.opt.spelllang = { 'en', 'ru' } -- set languages to spell check
vim.opt.spelloptions = 'camel' -- every upper-cased character in word indicates
                               -- start of new word 

-- Navigation
vim.opt.scrolloff = 5 -- minimal number of lines above and below cursor
vim.opt.splitright = true -- put new window right of current then :vsplit

-- Tabs
vim.opt.tabstop = 2 -- how many columns use to display \t
vim.opt.shiftwidth = 2 -- how many columns use per indent level
vim.opt.expandtab = true -- insert spaces then press <Tab>
vim.opt.softtabstop = 2 -- how many whitespaces add / remove then
                        -- <Tab> / <BS> is pressed
