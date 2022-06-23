local self = {}


self.background = "dark"
self.base = "stellarized"


-- =======
-- Colours
-- =======
local NONE = "NONE"
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
-- Code
local Normal = White

local Imports = BrighterViolet

local Parameter = Orange
local Class = Red
local Type = DarkerRed
local Variable = White
local Constant = DullYellow

local String = Grey
local Comment = DarkerGrey

local Constructor = Cyan
local Function = Violet
local Method = BrighterViolet

local Field = White

local Keyword = SkyBlue
local Operator = DarkerGrey
local Bracket = DarkerGrey

-- Constructs
local FilePath = DullYellow
local Dir = Orange

-- Editor Colors
local ColorColumn = SlightlyBackground
local CursorLine = SlightlyBackground
local Fold = DullYellow
local Guides = DullYellow
local FloatText = White

-- Status Line
local StatusLine = DullYellow

-- Diagnostics and supprt
local Inactive = Grey
local Chosen = Orange

local Error = Red
local Warning = Orange
local Hint = Grey

local Add = Green
local Change = Orange
local Delete = Red

local Pass = Green
local Running = DullYellow
local Fail = Red

-- ========
-- Handlers
-- ========
self.highlights = {
    -- Editor
    ColorColumn = { guibg = NONE, gui="underline", guisp=ColorColumn},
    CursorLine = { guibg=NONE, guisp=CursorLine, gui="underline" },
    Folded = { guifg = Fold, guibg = NONE, gui = NONE},
    VertSplit = { guifg = Guides, guibg = NONE },
    --Pmenu = { guifg=NONE, gui="nocombine" },

    StatusLine = { guifg = StatusLine, guibg = NONE },
    StatusLineNC = { guibg = NONE },

    SignifySignAdd = { guibg = NONE },
    SignifySignChange = { guibg = NONE },
    SignifySignDelete = { guibg = NONE },

    SignatureMarkText = { guibg = NONE },
    SignatureMarkerText = { guibg = NONE },

    SignColumn = { guibg = NONE, guifg = NONE },
    LineNr = { guifg = Inactive, guibg = NONE },
    CursorLineNr = { guifg = Chosen, gui = "bold,underline",  guisp = Chosen },

    NormalNC = { guibg = NONE },

    FloatBorder = { guifg = Guides, guibg = NONE },
    NormalFloat = { guifg = FloatText, guibg = NONE },

    WhiteSpace = { guibg = Error },

    -- GitSigns
    GitSignsAdd = { guibg = NONE, guifg = Add },
    GitSignsChange = { guibg = NONE, guifg = Change },
    GitSignsDelete = { guibg = NONE, guifg = Delete },

    --GitSignsAddNr = { guibg = NONE, guifg = NONE, guisp = Add, gui = NONE},
    --GitSignsChangeNr = { guibg = NONE, guifg = NONE, guisp = Change, gui = NONE},
    --GitSignsDeleteNr = { guibg = NONE, guifg = NONE, guisp = Delete, gui = NONE},

    --GitSignsAddLn = { guibg = NONE, gui = "underline", guisp = Add },
    --GitSignsChangeLn = { guibg = NONE, gui = "underline", guisp = Change },
    --GitSignsDeleteLn = { guifg = Delete, gui = "underline", guisp = Delete },

    gitDiff = { guifg = Normal },
    fugitiveHunk = { guifg = Normal },

    -- TS
    TSKeywordOperator = { guifg = Keyword, gui = "italic" },
    TSType = { guifg = Type },
    TSKeywordFunction = { guifg = Keyword, gui = "italic" },
    TSPunctSpecial = { guifg = Bracket },
    TSConstBuiltin = { guifg = Constant, gui = "italic" },
    TSBoolean = { guifg = Constant, gui = "italic" },
    TSFloat = { guifg = Constant, gui = "italic" },
    TSNumber = { guifg = Constant, gui = "italic" },
    TSRepeat = { guifg = Keyword, gui = "italic" },
    TSField = { guifg = Field },
    TSKeyword = { guifg = Keyword, gui = "italic" },
    TSKeywordReturn = { guifg = Keyword, gui = NONE },
    TSConstructor = { guifg = Constructor, gui = "bold" },
    TSComment = { guifg = Comment, gui = "italic" },
    TSVariableBuiltin = { gui = "italic" },
    TSPunctDelimiter = { guifg = Operator },
    TSConditional = { guifg = Keyword, gui = "italic" },
    TSOperator = { guifg = Operator },
    TSPunctBracket = { guifg = Bracket },
    TSInclude = { guifg = Imports, gui = NONE },
    TSVariable = { guifg = Variable },
    TSParameter = { guifg = Parameter },
    TSString = { guifg = String },
    TSMethod = { guifg = Method },
    TSFunction = { guifg = Function },
    TSException = { guifg = Keyword },

    -- Lsp
    DiagnosticError = { guifg = Error },
    DiagnosticWarning = { guifg = Warning },
    DiagnosticInformation = { guifg = Hint },
    DiagnosticHint = { guifg = Hint },

    DiagnosticVirtualTextError = { guifg = Error, gui=NONE },
    DiagnosticVirtualTextWarn = { guifg = Warning, gui=NONE },
    DiagnosticVirtualTextInfo= { guifg = Hint, gui=NONE },
    DiagnosticVirtualTextHint= { guifg = Hint, gui=NONE },

    DiagnosticUnderlineError = { gui="undercurl", guisp = Error },
    DiagnosticUnderlineWarning= { gui="undercurl", guisp =  Warning },
    DiagnosticUnderlineHint= { gui="undercurl", guisp = Hint },
    DiagnosticUnderlineInfo = { gui="undercurl", guisp = Hint },

    -- Status and Tab Line
    SLactive = { guibg = Chosen },
    SLinactive = { gui = 'underline', guisp=Inactive },
    SLfilepathsep = { guifg=Guides },
    SLfilepath = { guifg=FilePath, gui='bold' },
    SLlinecolsep = { guifg=Guides },
    SLlinecol = { guifg=Guides },
    SLmodified = { guifg=Change },
    SLmodifiedsep = { guifg=Guides },
    SLfiletype = { guifg=Type },
    SLfiletypesep = { guifg=Guides },

    -- Indent blank line
    IndentBlanklineChar = { guifg = Inactive },
    IndentBlanklineContextChar = { guifg = Chosen },

    IndentBlanklineContextStart = { guisp=Guides  },
    IndentBlanklineSpaceChar = { guisp=Guides },
    IndentBlanklineSpaceCharBlankline = { guisp=Guides },

    -- Ultest
    NeotestPassed = { guifg = Pass },
    NeotestFailed = { guifg = Fail },
    NeotestRunning = { guifg = Running },
    NeotestBorder = { guifg = Guides },
    NeotestSkipped = { guifg = Inactive },
    NeotestTest = { guifg = Function },
    NeotestFile = { guifg = FilePath },
    NeotestFocused = { guifg = Chosen },
    NeotestDir = { guifg = Dir },
    NeotestAdapterName = { guifg = Class },
    UltestSummaryNamespace = { guifg = Class },

    -- Git diffs
    DiffAdd = { guifg = Add, gui="underline", guisp=Add },
    DiffChange= { guifg = Change, gui="underline", guisp=Change },
    DiffDelete = { guifg = Delete, gui="underline", guisp=Delete },
    DiffText = { guifg = Change, gui="underline", guisp=Change  },
}

return self
