local lush = require('lush')
local hsl = lush.hsl


-- Taken from IBM Carbon : https://github.com/carbon-design-system/carbon/blob/v10/packages/colors/src/colors.js
local black = hsl("#000000")
local black100 = black;
local blackHover = hsl("#212121")

local white = hsl("#ffffff")
local white0 = white;
local whiteHover = hsl("#e8e8e8")

local yellow40 = hsl("#d2a106")
local yellow50 = hsl("#b28600")
local yellow60 = hsl("#8e6a00")
local yellow70 = hsl("#684e00")
local yellow80 = hsl("#483700")
local yellow90 = hsl("#302400")
local yellow100 = hsl("#1c1500")

local yellow40Hover = hsl("#bc9005")
local yellow50Hover = hsl("#9e7700")
local yellow60Hover = hsl("#755800")
local yellow70Hover = hsl("#806000")
local yellow80Hover = hsl("#5c4600")
local yellow90Hover = hsl("#3d2e00")
local yellow100Hover = hsl("#332600")
local x = yellow40Hover.rotate(180)

local orange40 = hsl("#ff832b")
local orange50 = hsl("#eb6200")
local orange60 = hsl("#ba4e00")
local orange70 = hsl("#8a3800")
local orange80 = hsl("#5e2900")
local orange90 = hsl("#3e1a00")
local orange100 = hsl("#231000")

local orange40Hover = hsl("#fa6800")
local orange50Hover = hsl("#cc5500")
local orange60Hover = hsl("#9e4200")
local orange70Hover = hsl("#a84400")
local orange80Hover = hsl("#753300")
local orange90Hover = hsl("#522200")
local orange100Hover = hsl("#421e00")

local red40 = hsl("#ff8389")
local red50 = hsl("#fa4d56")
local red60 = hsl("#da1e28")
local red70 = hsl("#a2191f")
local red80 = hsl("#750e13")
local red90 = hsl("#520408")
local red100 = hsl("#2d0709")

local red100Hover = hsl("#540d11")
local red90Hover = hsl("#66050a")
local red80Hover = hsl("#921118")
local red70Hover = hsl("#c21e25")
local red60Hover = hsl("#b81922")
local red50Hover = hsl("#ee0713")
local red40Hover = hsl("#ff6168")

local magenta40 = hsl("#ff7eb6")
local magenta50 = hsl("#ee5396")
local magenta60 = hsl("#d02670")
local magenta70 = hsl("#9f1853")
local magenta80 = hsl("#740937")
local magenta90 = hsl("#510224")
local magenta100 = hsl("#2a0a18")

local magenta100Hover = hsl("#53142f")
local magenta90Hover = hsl("#68032e")
local magenta80Hover = hsl("#8e0b43")
local magenta70Hover = hsl("#bf1d63")
local magenta60Hover = hsl("#b0215f")
local magenta50Hover = hsl("#e3176f")
local magenta40Hover = hsl("#ff57a0")

local purple40 = hsl("#be95ff")
local purple50 = hsl("#a56eff")
local purple60 = hsl("#8a3ffc")
local purple70 = hsl("#6929c4")
local purple80 = hsl("#491d8b")
local purple90 = hsl("#31135e")
local purple100 = hsl("#1c0f30")

local purple100Hover = hsl("#341c59")
local purple90Hover = hsl("#40197b")
local purple80Hover = hsl("#5b24ad")
local purple70Hover = hsl("#7c3dd6")
local purple60Hover = hsl("#7822fb")
local purple50Hover = hsl("#9352ff")
local purple40Hover = hsl("#ae7aff")

local blue40 = hsl("#78a9ff")
local blue50 = hsl("#4589ff")
local blue60 = hsl("#0f62fe")
local blue70 = hsl("#0043ce")
local blue80 = hsl("#002d9c")
local blue90 = hsl("#001d6c")
local blue100 = hsl("#001141")

local blue100Hover = hsl("#001f75")
local blue90Hover = hsl("#00258a")
local blue80Hover = hsl("#0039c7")
local blue70Hover = hsl("#0053ff")
local blue60Hover = hsl("#0050e6")
local blue50Hover = hsl("#1f70ff")
local blue40Hover = hsl("#5c97ff")

local cyan40 = hsl("#33b1ff")
local cyan50 = hsl("#1192e8")
local cyan60 = hsl("#0072c3")
local cyan70 = hsl("#00539a")
local cyan80 = hsl("#003a6d")
local cyan90 = hsl("#012749")
local cyan100 = hsl("#061727")

local cyan40Hover = hsl("#059fff")
local cyan50Hover = hsl("#0f7ec8")
local cyan60Hover = hsl("#005fa3")
local cyan70Hover = hsl("#0066bd")
local cyan80Hover = hsl("#00498a")
local cyan90Hover = hsl("#013360")
local cyan100Hover = hsl("#0b2947")

local teal40 = hsl("#08bdba")
local teal50 = hsl("#009d9a")
local teal60 = hsl("#007d79")
local teal70 = hsl("#005d5d")
local teal80 = hsl("#004144")
local teal90 = hsl("#022b30")
local teal100 = hsl("#081a1c")

local teal40Hover = hsl("#07aba9")
local teal50Hover = hsl("#008a87")
local teal60Hover = hsl("#006b68")
local teal70Hover = hsl("#007070")
local teal80Hover = hsl("#005357")
local teal90Hover = hsl("#033940")
local teal100Hover = hsl("#0f3034")

local green40 = hsl("#42be65")
local green50 = hsl("#24a148")
local green60 = hsl("#198038")
local green70 = hsl("#0e6027")
local green80 = hsl("#044317")
local green90 = hsl("#022d0d")
local green100 = hsl("#071908")

local green40Hover = hsl("#3bab5a")
local green50Hover = hsl("#208e3f")
local green60Hover = hsl("#166f31")
local green70Hover = hsl("#11742f")
local green80Hover = hsl("#05521c")
local green90Hover = hsl("#033b11")
local green100Hover = hsl("#0d300f")

local coolGray40 = hsl("#a2a9b0")
local coolGray50 = hsl("#878d96")
local coolGray60 = hsl("#697077")
local coolGray70 = hsl("#4d5358")
local coolGray80 = hsl("#343a3f")
local coolGray90 = hsl("#21272a")
local coolGray100 = hsl("#121619")

local coolGray40Hover = hsl("#9199a1")
local coolGray50Hover = hsl("#757b85")
local coolGray60Hover = hsl("#585e64")
local coolGray70Hover = hsl("#5d646a")
local coolGray80Hover = hsl("#434a51")
local coolGray90Hover = hsl("#2b3236")
local coolGray100Hover = hsl("#222a2f")

local gray40 = hsl("#a8a8a8")
local gray50 = hsl("#8d8d8d")
local gray60 = hsl("#6f6f6f")
local gray70 = hsl("#525252")
local gray80 = hsl("#393939")
local gray90 = hsl("#262626")
local gray100 = hsl("#161616")

local gray40Hover = hsl("#999999")
local gray50Hover = hsl("#7a7a7a")
local gray60Hover = hsl("#5e5e5e")
local gray70Hover = hsl("#636363")
local gray80Hover = hsl("#474747")
local gray90Hover = hsl("#333333")
local gray100Hover = hsl("#292929")

local warmGray40 = hsl("#ada8a8")
local warmGray50 = hsl("#8f8b8b")
local warmGray60 = hsl("#726e6e")
local warmGray70 = hsl("#565151")
local warmGray80 = hsl("#3c3838")
local warmGray90 = hsl("#272525")
local warmGray100 = hsl("#171414")

local warmGray40Hover = hsl("#9c9696")
local warmGray50Hover = hsl("#7f7b7b")
local warmGray60Hover = hsl("#605d5d")
local warmGray70Hover = hsl("#696363")
local warmGray80Hover = hsl("#4c4848")
local warmGray90Hover = hsl("#343232")
local warmGray100Hover = hsl("#2c2626")

local pink = hsl("#e642f5")
local guide = magenta60
local selection = teal90Hover.mix(green90, 50)
local structure = teal40
local comment = gray70
local bg = warmGray100.darken(40)

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `{}` will clear all styling, leaving elements looking
        -- like the 'Normal' group.
        -- To be able to link to a group, it must already be defined, so you may have
        -- to reorder items as you go.
        -- See :h highlight-groups

        Comment { fg = comment }, -- Any comment
        ColorColumn { bg = purple40 }, -- Columns set with 'colorcolumn'
        Conceal {}, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor { fg = purple40 }, -- Character under the cursor
        lCursor { Cursor }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn { bg = selection }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine { bg = selection.darken(50) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory { fg = cyan40 }, -- Directory names (and other special names in listings)
        DiffAdd { fg = green50Hover, bg = blackHover }, -- Diff mode: Added line |diff.txt|
        diffAdded { DiffAdd },
        DiffChange { fg = teal50Hover.lighten(30) }, -- Diff mode: Changed line |diff.txt|
        DiffDelete { fg = red50Hover }, -- Diff mode: Deleted line |diff.txt|
        DiffText { fg = teal50Hover.lighten(30) }, -- Diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer {}, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        -- TermCursor   { }, -- Cursor in a focused terminal
        -- TermCursorNC { }, -- Cursor in an unfocused terminal
        ErrorMsg { fg = red50 }, -- Error messages on the command line
        VertSplit { fg = guide }, -- Column separating vertically split windows
        Folded { fg = orange40Hover.darken(40) }, -- Line used for closed folds
        FoldColumn { Folded }, -- 'foldcolumn'
        LineNr { fg = purple40, bg = bg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { fg = guide.lighten(10), bg = bg, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen { fg = yellow40, gui = "bold" }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea      { }, -- Area for messages and cmdline
        -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- MoreMsg      { }, -- |more-prompt|
        -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal { fg = white, bg = bg }, -- Normal text
        SignColumn { Normal }, -- Column where |signs| are displayed
        -- NormalFloat { Normal,  }, -- Normal text in floating windows.
        -- NormalNC { Normal }, -- normal text in non-current windows
        Pmenu { Normal, bg = warmGray100 }, -- Popup menu: Normal item.
        -- PmenuSel     { }, -- Popup menu: Selected item.
        -- PmenuSbar    { }, -- Popup menu: Scrollbar.
        -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
        -- Question     { }, -- |hit-enter| prompt and yes/no questions
        -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search { bg = selection }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        IncSearch { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Substitute { Search }, -- |:substitute| replacement text highlighting
        -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine { fg = black, bg = guide, gui = "bold" }, -- Status line of current window
        StatusLineNC { fg = guide, gui = "bold", bg = Normal.bg.lighten(2) }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        -- TabLine      { }, -- Tab pages line, not active tab page label
        -- TabLineFill  { }, -- Tab pages line, where there are no labels
        -- TabLineSel   { }, -- Tab pages line, active tab page label
        -- Title        { }, -- Titles for output from ":set all", ":autocmd" etc.
        Visual { CursorLine }, -- Visual mode selection
        -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg { fg = orange40 }, -- Warning messages
        Whitespace { fg = red60 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        -- Winseparator { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        WildMenu { bg = selection }, -- Current match in 'wildmenu' completion

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.


        Constant { fg = purple40 }, -- (*) Any constant
        String { fg = green40 }, --   A string constant: "this is a string"
        Character { fg = orange40 }, --   A character constant: 'c', '\n'
        Number { fg = orange40 }, --   A number constant: 234, 0xff
        Boolean { fg = orange40 }, --   A boolean constant: TRUE, false
        Float { fg = orange40 }, --   A floating point constant: 2.3e10

        Identifier {}, -- (*) Any variable name
        Function { fg = pink, gui = "bold" }, --   Function name (also: methods for classes)

        Statement { fg = structure.darken(40) }, -- (*) Any statement
        -- Conditional    { }, --   if, then, else, endif, switch, etc.
        -- Repeat         { }, --   for, do, while, etc.
        -- Label          { }, --   case, default, etc.
        -- Operator       {}, --   "sizeof", "+", "*", etc.
        -- Keyword        { }, --   any other keyword
        -- Exception      { }, --   try, catch, throw

        -- PreProc        { }, -- (*) Generic Preprocessor
        Include { fg = blue40 }, --   Preprocessor #include
        -- Define         { }, --   Preprocessor #define
        -- Macro          { }, --   Same as Define
        -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

        Type { fg = blue40, gui = "nocombine" }, -- (*) int, long, char, etc.
        -- StorageClass   { }, --   static, register, volatile, etc.
        -- Structure      { }, --   struct, union, enum, etc.
        -- Typedef        { }, --   A typedef

        -- Special        { }, -- (*) Any special symbol
        -- SpecialChar    { }, --   Special character in a constant
        -- Tag            { }, --   You can use CTRL-] on this
        -- Delimiter      { }, --   Character that needs attention
        -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
        -- Debug          { }, --   Debugging statements

        -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
        -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        -- Error          { }, -- Any erroneous construct
        Todo { fg = guide, gui = "bold" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

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
        -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
        -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
        -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
        -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
        -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
        -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
        -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
        -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

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

        sym"@text.literal"      { fg = teal40 }, -- Comment
        sym"@text.reference"    { fg = yellow40 }, -- Identifier
        -- sym"@text.title"        { }, -- Title
        -- sym"@text.uri"          { }, -- Underlined
        -- sym"@text.underline"    { }, -- Underlined
        sym "@text.todo"         { Todo}, --{  fg = guide, gui = "bold"}, -- Todo
        -- sym"@comment"           { }, -- Comment
        -- sym"@punctuation"       { }, -- Delimiter
        sym "@punctuation.bracket" { fg = yellow40.darken(60) }, -- Delimiter
        sym "@punctuation.delimiter" { fg = yellow40.darken(60) }, -- Delimiter
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
        sym "@function.builtin" { fg = orange40, gui = "bold" }, -- Special
        -- sym"@function.macro"    { }, -- Macro
        sym "@function.call" { fg = orange40 }, -- Macro
        -- sym"@parameter"         { }, -- Identifier
        sym "@method" { fg = Function.fg.lighten(30), gui = "bold" }, -- Function
        sym "@function" { fg = Function.fg.lighten(30), gui = "bold" }, -- Function
        sym "@field" { fg = white }, -- Identifier
        -- sym"@property"          { }, -- Identifier
        sym "@constructor" { Type, gui = "nocombine" }, -- Special
        -- sym"@conditional"       { }, -- Conditional
        -- sym"@repeat"            { }, -- Repeat
        -- sym"@label"             { }, -- Label
        -- sym"@keyword"           { }, -- Keyword
        -- sym"@exception"         { }, -- Exception
        sym "@variable.builtin" { gui = "bold" }, -- Identifier
        sym "@operator" { fg = teal40, gui = "nocombine" }, -- Operator
        -- sym"@type"              { }, -- Type
        -- sym"@type.definition"   { }, -- Typedef
        -- sym"@storageclass"      { }, -- StorageClass
        -- sym"@structure"         { }, -- Structure
        -- sym"@namespace"         { }, -- Identifier
        sym "@attribute.builtin" { fg = pink, gui = "bold" },
        sym "@attribute" { fg = cyan40, gui = "italic,bold" },
        -- sym"@include"           { }, -- Include
        -- sym"@preproc"           { }, -- PreProc
        -- sym"@debug"             { }, -- Debug
        -- sym"@tag"               { }, -- Tag
        sym "@text.note" { fg = green40 }, -- Function
        sym "@method.call" { fg = cyan40 }, -- Function
        sym "@string.documentation" { fg = green40.darken(50) }, -- SpecialComment
        sym "@keyword.function" { fg = teal40, gui = "bold" }, -- SpecialComment
        sym "@keyword.operator" { fg = teal40 }, -- SpecialComment
        sym "@text.title" { fg = guide, gui = "italic,bold" }, -- SpecialComment

        lualine_a_normal { fg = black, bg = guide },
        lualine_b_normal { fg = black, bg = guide },
        lualine_c_normal { fg = black, bg = guide },

        lualine_a_insert { fg = black, bg = guide },
        lualine_b_insert { fg = black, bg = guide },
        lualine_c_insert { fg = black, bg = guide },

        lualine_a_visual { fg = black, bg = guide },
        lualine_b_visual { fg = black, bg = guide },
        lualine_c_visual { fg = black, bg = guide },

        lualine_a_replace { fg = black, bg = guide },
        lualine_b_replace { fg = black, bg = guide },
        lualine_c_replace { fg = black, bg = guide },

        lualine_a_command { fg = black, bg = guide },
        lualine_b_command { fg = black, bg = guide },
        lualine_c_command { fg = black, bg = guide },

        lualine_a_terminal { fg = black, bg = guide },
        lualine_b_terminal { fg = black, bg = guide },
        lualine_c_terminal { fg = black, bg = guide },

        lualine_a_inactive { fg = white, bg = StatusLineNC.bg },
        lualine_b_inactive { fg = white, bg = StatusLineNC.bg },
        lualine_c_inactive { fg = white, bg = StatusLineNC.bg },

        GitSignsAdd { fg = green40, bg = Normal.bg },
    }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
