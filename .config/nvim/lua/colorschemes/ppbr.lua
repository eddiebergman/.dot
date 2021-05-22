-- =======
-- Colours
-- =======
local DullYellow = "#a5894A"
local DullerYellow = "#715e33"
local DefaultBackground = '#222532'
local NoteBackground = '#24293A'
local HighlightBackground = "#2d3243"
local Grey = "#9d8875"
local DarkerGrey = "#676765"
local Green = "#2a7916"
local Violet = "#826eaf"
local BrighterViolet = "#9989BE"
local SkyBlue = "#4c73c2"
local Cyan = "#20A9B1"
local DarkerCyan = "#198086"
local Orange = "#F79000"
local Red = "#ca7375"
local White = "#a29f92"

-- ===========
-- Basic setting
-- ===========
local FunctionDef = DarkerCyan
local ClassDef = Red
local Type = Red
local MethodCall = BrighterViolet
local FunctionCall = Violet
local Variable = White
local Structure = SkyBlue
local Keyword = SkyBlue
local Operator = DarkerGrey
local Constant = DullYellow
local String = Grey
local Comment = DarkerGrey

local Error = Red
local Warning = Orange
local Hint = Grey

local highlights = {
    -- Base Syntax Types
    Structure = { guifg = Structure, gui="bold" },
    Type = { guifg =  Type },
    Todo = { guifg = SkyBlue, gui="bold" },

    -- Lsp
    LspDiagnosticsDefaultError = { guifg = Error },
    LspDiagnosticsUnderlineError = { gui="undercurl", guisp = Error },

    LspDiagnosticsDefaultWarning = { guifg = Warning },
    LspDiagnosticsUnderlineWarning= { gui="undercurl", guisp =  Warning },

    LspDiagnosticsDefaultInformation = { guifg = Hint },
    LspDiagnosticsUnderlineInformation= { gui="undercurl", guisp = Hint },

    LspDiagnosticsDefaultHint = { guifg = Hint },
    LspDiagnosticsUnderlineHint= { gui="undercurl", guisp = Hint },

    -- Editor
    CursorLineNr = { guifg = Grey, gui="bold" },
    LineNr = { guifg = Grey },
    ColorColumn = { guibg = NoteBackground },
    Folded = { guifg = DullerYellow, guibg = "NONE", gui = "NONE"},

    -- Tree Sitter (General)
    TSVariableBuiltin = { guifg = Variable, gui="bold" },
    TSConstant = { guifg = Type, gui="nocombine,NONE" },
    TSType = { guifg = Type, gui="NONE" },
    TSKeyword = { guifg = Keyword },
    TSVariable = { guifg = Variable },
    TSProperty = { guifg = Variable },
    TSParameter = { guifg = Variable },
    TSConditional = { guifg = Keyword },
    TSRepeat = { guifg = Keyword },
    TSString = { guifg = String },
    TSKeywordOperator = { guifg = Keyword },
    TSOperator = { guifg = Operator },
    TSMethod = { guifg =  MethodCall },
    TSFuncBuiltin = { guifg = FunctionCall, gui = "nocombine,NONE"},
    TSFunction = { guifg = DarkerCyan, gui="NONE" },
    TSPunctBracket = { guifg = Operator },
    TSPunctDelimiter = { guifg = Operator },
    TSField = { guifg = Variable },
    TSConstructor = { guifg = FunctionDef, gui="nocombine,NONE" },
    TSConstBuiltin = { guifg = Constant, gui="NONE" },
    TSPunctSpecial = { guifg = Operator },
    TSNumber = { guifg = Constant },
    TSComment = { guifg = Comment, gui="italic" },
    TSInclude = { guifg = Violet },
    TSKeywordFunction = { guifg = Keyword },
    TSBoolean = { guifg = Constant }

}

return highlights
