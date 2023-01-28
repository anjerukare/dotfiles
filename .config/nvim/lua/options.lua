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
vim.opt.fillchars = 'eob: ,fold: ' -- hide ~'s at the end of buffer
                                   -- and hide ·'s at the end of folding
vim.opt.showtabline = 2 -- show tabline always
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu
vim.opt.cmdheight = 0 -- show command line at the bottom only when it necessary

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

---@return {name:string, text:string, texthl:string}[]
local function get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

-- Status column with gitsigns and other signs separated
_G.Status = {}
_G.Status.column = function()
  local sign, git_sign
  local signs = get_signs()
  for i = #signs, 1, -1 do
    s = signs[i]
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end
  local components = {
    git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text .. "%*")
      or "",
    [[%=]],
    sign and ("%#" .. (sign.texthl or "") .. "#" .. sign.text .. "%*")
      or [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
  }
  return table.concat(components, "")
end

vim.opt.statuscolumn = [[%!v:lua.Status.column()]]

