local self = {}


self.background = "dark"
self.base = "stellarized"


-- =======
-- Colours
-- =======
local DullYellow = "#a5894A"
local DullerYellow = "#715e33"
local DefaultBackground = '#222532'
local InactiveBackground = DefaultBackground
local SlightlyBackground = '#242835'
local NoteBackground = '#24293A'
local DarkerBackground = '#12131a'
local HighlightBackground = "#2d3243"
local Grey = "#9d8875"
local DarkerGrey = "#676765"
local EvenDarkerGrey = "#424141"
local Green = "#2a7916"
local Violet = "#826eaf"
local BrighterViolet = "#9989BE"
local SkyBlue = "#4c73c2"
local Cyan = "#20A9B1"
local DarkerCyan = "#198086"
local Orange = "#F79000"
local Red = "#ca7375"
local DarkerRed = "#b56769"
local MurkyRed = "#8d5051"
local Peach = "#dfabac"
local White = "#a29f92"

-- ===========
-- Basic setting
-- ===========
local Function = DarkerCyan
local Class = Red
local Type = DarkerRed
local MethodCall = BrighterViolet
local FunctionCall = Violet
local Variable = White
local Structure = SkyBlue
local Include = Violet
local Keyword = SkyBlue
local Operator = DarkerGrey
local Guides = EvenDarkerGrey
local Constant = DullYellow
local String = Grey
local Comment = DarkerGrey
local Normal = White
local Parameter = Orange

local Error = Red
local Warning = Orange
local Hint = Grey

-- ========
-- Handlers
-- ========
self.highlights = {

    -- Base Syntax for languages
    Comment = { guifg = Comment },
    Constant = { guifg = Constant },
    String = { guifg = String },
    Character = { guifg = Comment },
    Number = { guifg = Constant },
    Boolean = { guifg = Constant },
    Float = { guifg = Constant },
    Identifier = { guifg = Variable },
    Function = { guifg = Function },
    Statement = { guifg = Structure },
    Conditional = { guifg = Structure },
    Repeat = { guifg = Structure },
    Label = { guifg = Structure },
    Operator = { guifg = Operator },
    Keyword = { guifg = Keyword },
    Exception = { guifg = Structure },
    Include = { guifg = Include },
    Type = { guifg = Type },
    Normal = { guifg = Normal },
    Underlined = { guifg = Normal, gui="underline" },
    Ignore = { guifg = Normal },
    Error = { guifg = Error },
    Todo = { guifg = SkyBlue, gui="bold" },
    Special = { guifg = SkyBlue },

    -- Editor
    CursorLineNr = { guifg = Grey, gui="bold" },
    LineNr = { guifg = Grey },
    ColorColumn = { guibg = SlightlyBackground },
    CursorLine = { guibg = SlightlyBackground, gui="underline", guisp=Guides },
    Folded = { guifg = DullerYellow, guibg = "NONE", gui = "NONE"},
    IndentBlanklineChar = { guifg = Guides, gui='nocombine' },
    IndentBlanklineContextChar = { guifg=DullerYellow, gui='nocombine' },
    VertSplit = { guifg = DullerYellow, guibg = "NONE" },
    StatusLine= { guifg = DullerYellow, guibg = "NONE" },
    StatusLineNC = { guibg = "NONE" },
    FloatBorder = { guifg = DullerYellow },
    NormalFloat = { guibg = "NONE" },
    NormalNC = { guibg = InactiveBackground },
    WhiteSpace = { guibg = Error },

    -- Lsp
    DiagnosticError = { guifg = Error },
    DiagnosticWarning = { guifg = Warning },
    DiagnosticInformation = { guifg = Hint },
    DiagnosticHint = { guifg = Hint },

    DiagnosticUnderlineError = { gui="undercurl", guisp = Error },
    DiagnosticUnderlineWarning= { gui="undercurl", guisp =  Warning },
    DiagnosticUnderlineHint= { gui="undercurl", guisp = Hint },
    DiagnosticUnderlineInfo = { gui="undercurl", guisp = Hint },

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
    TSStringEscape = { guifg = Comment },
    TSKeywordOperator = { guifg = Keyword },
    TSOperator = { guifg = Operator },
    TSMethod = { guifg =  MethodCall },
    TSFuncBuiltin = { guifg = FunctionCall, gui = "nocombine,NONE"},
    TSFunction = { guifg = Function, gui="NONE" },
    TSPunctBracket = { guifg = Operator },
    TSPunctDelimiter = { guifg = Operator },
    TSField = { guifg = Variable },
    TSConstructor = { guifg = Function, gui="nocombine,NONE" },
    TSConstBuiltin = { guifg = Constant, gui="NONE" },
    TSPunctSpecial = { guifg = Operator },
    TSNumber = { guifg = Constant },
    TSComment = { guifg = Comment, gui="italic" },
    TSInclude = { guifg = Include },
    TSKeywordFunction = { guifg = Keyword },
    TSBoolean = { guifg = Constant },

    -- Nvim-cmp Completion
    CmpItemAbbr = { guifg = Comment },
    CmpItemAbbrDeprecated = { guifg = Comment },
    CmpItemAbbrMatch = { guifg = Normal },
    CmpItemAbbrMatchFuzzy = { guifg = Normal },
    CmpItemKind = { guifg = Type },
    CmpItemMenu = { guibg = SlightyBackground, guifg = DullerYellow },
    CmpItemKindText = { guifg = Normal },
    CmpItemKindMethod = { guifg = MethodCall },
    CmpItemKindFunction = { guifg = Function },
    CmpItemKindConstructor = { guifg = Function, gui = "nocombine,NONE" },
    CmpItemKindField = { guifg = Variable },
    CmpItemKindVariable = { guifg = Variable },
    CmpItemKindClass = { guifg = Type  },
    CmpItemKindModule = { guifg = Include },
    CmpItemKindProperty = { guifg = Variable },
    CmpItemKindKeyword = { guifg = Keyword },
    CmpItemKindSnippet = { guifg = String },
    CmpItemKindFile = { guifg = String },
    CmpItemKindFolder = { guifg = String },
    CmpItemKindConstant = { guifg = Type, gui="nocombine,NONE" },
    CmpItemKindOperator = { guifg = Operator },
    CmpItemKindTypeParameter = { guifg = Type },

    -- Status and Tab Line
    SLactive = { guibg = Guides },
    SLinactive = { guibg = "NONE", gui = 'underline', guisp=DullerYellow },
    SLfilepathsep = { guifg=Comment },
    SLfilepath = { guifg=DullYellow, gui='bold' },
    SLlinecolsep = { guifg=Comment },
    SLlinecol = { guifg=Type },
    SLmodified = { guifg=Green },
    SLmodifiedsep = { guifg=Green },
    SLfiletype = { guifg=Keyword },
    SLfiletypesep = { guifg=Keyword },

    TL = { guibg = "NONE" },
    TLpre = { guifg=Constant },
    TLenvsep = { guifg=Guides },
    TLenv = { guifg=Type, gui="bold" },
    TLtimesep = { guifg=Guides },
    TLtime = { guifg=Constant, },
    TLgitsep = { guifg=Guides },
    TLgitorg = { guifg=Type },
    TLgitbranch = { guifg=Type, gui="bold" },
    TLi3 = { guifg=Type, gui="bold" },
    TLi3sep = { guifg=Guides },

    -- Files
    netrwCode = { guifg=Constant },
    netrwDir = { guifg=Constant, gui="bold" },
    netrwConfig = { guifg=Include },
    netrwObscure = { guifg=Comment },
    netrwSeperator = { guifg=Function },

    -- NvimTree
    NvimTreeNormal = { guifg=Constant },
    NvimTreeFolderName = { guifg=DarkerCyan },
    NvimTreeOpenedFolderName = { guifg=DarkerCyan, gui="bold" },
    NvimTreeOpenedFile = { guifg=BrighterViolet },
    NvimTreeMarkdownFile = { guifg=BrighterViolet, },
    NvimTreeSpecialFile = { guifg=BrighterViolet, },
    NvimTreeExecFile = { guifg=BrighterViolet, },
    NvimTreeImageFile = { guifg=BrighterViolet, },
}

return self
