--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local colors = require('colors')

vim.opt.cursorcolumn = false
vim.opt.termguicolors = true

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- See :h highlight-groups
    Normal       { fg = colors.white }, -- Normal text
    Cursor       { reverse = true }, -- Character under the cursor
    LineNr       { fg = colors.grey }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLine { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineNr { fg = colors.reddish }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    Visual       { fg = colors.white, bg = colors.reddish }, -- Visual mode selection
    VisualNOS    { Visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    MatchParen   { fg = colors.white, bg = colors.reddish }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    Search       { fg = colors.white, bg = colors.dark_reddish }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch    { fg = colors.white, bg = colors.reddish }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"

    TabLine      { }, -- Tab pages line, not active tab page label
    TabLineFill  { }, -- Tab pages line, where there are no labels
    TabLineSel   { fg = colors.reddish }, -- Tab pages line, active tab page label
    StatusLine   { fg = colors.white }, -- Status line of current window
    StatusLineNC { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    ModeMsg      { fg = colors.reddish }, -- 'showmode' message (e.g., "-- INSERT -- ")

    Directory    { fg = colors.green }, -- Directory names (and other special names in listings)

    VertSplit    { fg = colors.dark_grey }, -- Column separating vertically split windows
    NormalFloat  { }, -- Normal text in floating windows.
    Pmenu        { }, -- Popup menu: Normal item.
    PmenuSel     { fg = colors.white, bg = colors.reddish }, -- Popup menu: Selected item.
    PmenuSbar    { }, -- Popup menu: Scrollbar.
    PmenuThumb   { bg = colors.grey }, -- Popup menu: Thumb of the scrollbar.
    WildMenu     { PmenuSel }, -- Current match in 'wildmenu' completion

    Folded       { fg = colors.light_grey }, -- Line used for closed folds
    FoldColumn   { fg = colors.grey }, -- 'foldcolumn'
    SignColumn   { }, -- Column where |signs| are displayed

    ErrorMsg     { fg = colors.reddish }, -- Error messages on the command line
    WarningMsg   { fg = colors.light_grey }, -- Warning messages
    Question     { fg = colors.green }, -- |hit-enter| prompt and yes/no questions

    SpellBad     { undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap     { undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal   { undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare    { undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

    -- FIXME
    -- + syntax highlighting remains visible
    -- - too many background color for transparent colorscheme
    DiffAdd      { bg = colors.green.darken(93) }, -- Diff mode: Added line |diff.txt|
    DiffChange   { }, -- Diff mode: Changed line |diff.txt|
    DiffDelete   { fg = colors.reddish.darken(95), bg = colors.reddish.darken(95) }, -- Diff mode: Deleted line |diff.txt|
    DiffText     { bg = colors.greeny.darken(85) }, -- Diff mode: Changed text within a changed line |diff.txt|

    lCursor      { Cursor }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM     { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
    TermCursor   { Cursor }, -- Cursor in a focused terminal
    TermCursorNC { }, -- Cursor in an unfocused terminal

    ColorColumn  { bg = colors.dark_grey }, -- Columns set with 'colorcolumn'
    Conceal      { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    MsgArea      { }, -- Area for messages and cmdline
    MsgSeparator { fg = colors.grey }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { fg = colors.green }, -- |more-prompt|
    NonText      { fg = colors.grey }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    Title        { bold = true }, -- Titles for output from ":set all", ":autocmd" etc.

    -- See :h group-name
    Comment        { fg = colors.light_grey }, -- Any comment

    Constant       { fg = colors.reddish }, -- (*) Any constant
    -- String         { }, --   A string constant: "this is a string"
    -- Character      { }, --   A character constant: 'c', '\n'
    -- Number         { }, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier     { fg = colors.greeny }, -- (*) Any variable name
    -- Function       { }, --   Function name (also: methods for classes)

    Statement      { fg = colors.green }, -- (*) Any statement
    -- Conditional    { }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    -- Operator       { }, --   "sizeof", "+", "*", etc.
    -- Keyword        { }, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc        { fg = colors.light_grey }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { bold = true }, -- (*) int, long, char, etc.
    StorageClass   { fg = colors.green }, --   static, register, volatile, etc.
    Structure      { }, --   struct, union, enum, etc.
    Typedef        { fg = colors.green }, --   A typedef

    Special        { fg = colors.light_grey }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    -- Delimiter      { }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { underline = true }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { fg = colors.reddish }, -- Any erroneous construct
    Todo           { fg = colors.reddish }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { fg = colors.reddish } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg = colors.light_grey } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = colors.light_grey } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = colors.light_grey } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineError   { undercurl = true, sp = colors.reddish } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { undercurl = true, sp = colors.light_grey } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { undercurl = true, sp = colors.light_grey } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { undercurl = true, sp = colors.light_grey } , -- Used to underline "Hint" diagnostics.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag

    -- Telescope highlight-groups
    TelescopeBorder        { VertSplit },
    TelescopeTitle         { fg = colors.white }, -- not working out of :Lushify
    TelescopePromptCounter { fg = colors.light_grey },
    TelescopeMatching      { fg = colors.white },
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
