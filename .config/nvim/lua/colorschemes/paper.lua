local self = {}

local white = "#eeeeee"
local red = "#af0000"
local green = "#008700"
local olive = "#5f8700"
local blue = "#0087af"
local grey = "#878787"
local teal = "#005f87"
local browny = "#444444"
local lightgrey = "#bcbcbc"
local red = "#d70000"
local pink = "#d70087"
local purple = "#8700af"
local orange = "#d75f00"
local lightorange = "#d75f00"
local deepblue = "#005faf"
local darkerblue = "#005f87"

local Keyword = purple
local Operator = blue
local Bracket = blue
local Imports = teal
local Normal = grey
local Parameter = browny
local String = darkerblue
local Field = grey
local Variable = browny
local Constructor = lightorange
local Comment = lightgrey
local Constant = pink
local Error = red
local Warning = orange
local Hint = olive
local Guides = pink
local Type = lightorange
local Function = green
local Fold = orange
local Change = purple
local Delete = red
local Add = green


self.background = "light"
self.base = "PaperColor"

self.highlights = {
    -- Editor
    ColorColumn = { guibg = "NONE" },
    CursorLine = { guibg="NONE", guisp=Guides },
    Folded = { guifg = Fold, guibg = "NONE", gui = "NONE"},
    VertSplit = { guifg = Guides, guibg = "NONE" },

    StatusLine = { guifg = Guides, guibg = "NONE" },
    StatusLineNC = { guibg = "NONE" },

    SignifySignAdd = { guibg = "NONE" },
    SignifySignChange = { guibg = "NONE" },
    SignifySignDelete = { guibg = "NONE" },

    SignatureMarkText = { guibg = "NONE" },
    SignatureMarkerText = { guibg = "NONE" },

    SignColumn = { guibg = "NONE", guifg = "NONE" },
    LineNr = { guifg = Type, guibg = "NONE" },

    NormalNC = { guibg = "NONE" },

    FloatBorder = { guifg = Guides, guibg = "NONE" },
    NormalFloat = { guifg = Normal, guibg = "NONE" },

    WhiteSpace = { guibg = Error },


    -- GitSigns
    GitSignsAdd = { guibg = "NONE", guifg = Add },
    GitSignsChange = { guibg = "NONE", guifg = Change },
    GitSignsDelete = { guibg = "NONE", guifg = Delete },

    GitSignsAddLn = { guibg = "NONE", gui = "underline", guisp = Add },
    GitSignsChangeLn = { guibg = "NONE", gui = "underline", guisp = Change },
    GitSignsDeleteLn = { guifg = Delete, guibg = "NONE", gui = "underline", guisp = Delete },

    gitDiff = { guifg = Normal },
    fugitiveHunk = { guifg = Normal },

    -- TS
    TSKeywordOperator = { guifg = Keyword, gui = "italic" },
    TSType = { guifg = Type },
    TSKeywordFunction = { guifg = Keyword, gui = "italic" },
    TSFunction = { guifg = Function },
    TSMethod = { guifg = Function },
    TSFuncBuiltin = { guifg = Function },
    TSPunctSpecial = { guifg = Bracket },
    TSConstBuiltin = { guifg = Constant, gui = "italic" },
    TSBoolean = { guifg = Constant, gui = "italic" },
    TSFloat = { guifg = Constant, gui = "italic" },
    TSNumber = { guifg = Constant, gui = "italic" },
    TSRepeat = { guifg = Keyword, gui = "italic" },
    TSField = { guifg = Field },
    TSKeyword = { guifg = Keyword, gui = "italic" },
    TSKeywordReturn = { guifg = Keyword, gui = "NONE" },
    TSConstructor = { guifg = Constructor, gui = "bold" },
    TSComment = { guifg = Comment, gui = "italic" },
    TSVariableBuiltin = { gui = "italic" },
    TSPunctDelimiter = { guifg = Operator },
    TSConditional = { guifg = Keyword, gui = "italic" },
    TSString = { gui = "NONE" },
    TSOperator = { guifg = Operator },
    TSPunctBracket = { guifg = Bracket },
    TSInclude = { guifg = Imports, gui = "NONE" },
    TSVariable = { guifg = Variable },
    TSParameter = { guifg = Parameter },
    TSString = { guifg = String },

    -- Lsp
    DiagnosticError = { guifg = Error },
    DiagnosticWarning = { guifg = Warning },
    DiagnosticInformation = { guifg = Hint },
    DiagnosticHint = { guifg = Hint },

    DiagnosticUnderlineError = { gui="undercurl", guisp = Error },
    DiagnosticUnderlineWarning= { gui="undercurl", guisp =  Warning },
    DiagnosticUnderlineHint= { gui="undercurl", guisp = Hint },
    DiagnosticUnderlineInfo = { gui="undercurl", guisp = Hint },
}

return self
