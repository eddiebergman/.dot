local self = {}

-- https://www.reddit.com/r/gruvbox/comments/np5ylp/official_resources/
-- https://github.com/morhetz/gruvbox-contrib
local NONE = "NONE"

local bg0 = "#282828"
local bg0Strong = "#928374"
local Red = "#CC241D"
local RedStrong = "#FB4934"
local Green = "#98971A"
local GreenStrong = "#B8BB26"
local Yellow = "#D79921"
local YellowStrong= "#FABD2F"
local Blue = "#458588"
local BlueStrong = "#83A598"
local Purple = "#B16286"
local PurpleStrong = "#D3869B"
local Aqua = "#689D6A"
local AquaStrong = "#8EC07C"
local Orange = "#D65D0E"
local OrangeStrong = "#FE8019"
local Foreground = "#A89984"
local ForegroundStrong = "#EBDBB2"

local bg1Hard = "#1D2021"
local fg1Hard = "#FBF1C7"
local bg1Soft = "#32302F"
local fg1Soft = "#FBF1C7"
local bg1 = "#3C3836"
local fg1 = "#EBDBB2"
local bg2 = "#504945"
local fg2 = "#D5C4A1"
local bg3 = "#665C54"
local fg3 = "#BDAE93"
local bg4 = "#7C6F64"
local fg4 = "#A89984"

local grey = "#878787"

local BlueDeep = "#0997d9"

local Keyword = RedStrong
local Operator = BlueStrong
local Bracket = Orange
local Imports = Red
local Normal = fg3
local Parameter = Aqua
local String = Yellow
local Field = fg3
local Variable = fg3
local Constructor = Orange
local Comment = Blue
local Constant = OrangeStrong
local Error = RedStrong
local Warning = OrangeStrong
local Hint = Blue
local Guides = fg1Soft
local Type = BlueDeep

local Add = GreenStrong
local Change = PurpleStrong
local Delete = RedStrong

local Pass = Green
local Running = Yellow
local Fail = RedStrong

local Chosen = PurpleStrong

vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_bold = 0

self.background = "dark"
self.base = "gruvbox"

self.highlights = {

    -- Editor
    ColorColumn = { guibg = "NONE" },
    CursorLine = { guibg="NONE", guisp=Blue, gui="underline" },
    Folded = { guifg = BlueStrong, guibg = "NONE", gui = "NONE"},
    VertSplit = { guifg = BlueStrong, guibg = "NONE" },

    StatusLine = { guifg = Yellow, guibg = "NONE" },
    StatusLineNC = { guibg = "NONE" },

    SignifySignAdd = { guibg = "NONE" },
    SignifySignChange = { guibg = "NONE" },
    SignifySignDelete = { guibg = "NONE" },

    SignatureMarkText = { guibg = "NONE" },
    SignatureMarkerText = { guibg = "NONE" },

    SignColumn = { guibg = "NONE", guifg = "NONE" },
    LineNr = { guifg = Blue, guibg = "NONE" },

    NormalNC = { guibg = "NONE" },

    FloatBorder = { guifg = Blue, guibg = "NONE" },
    NormalFloat = { guifg = fg1Hard, guibg = "NONE" },

    WhiteSpace = { guibg = Error },

    -- GitSigns
    GitSignsAdd = { guibg = "NONE", guifg = Add },
    GitSignsChange = { guibg = "NONE", guifg = Change },
    GitSignsDelete = { guibg = "NONE", guifg = Delete },

    GitSignsAddLn = { guibg = NONE, gui = "underline", guisp = Add },
    GitSignsChangeLn = { guibg = NONE, gui = "underline", guisp = Change },
    GitSignsDeleteLn = { guifg = Delete, guibg = "NONE", gui = "underline", guisp = Delete },

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

    -- Status and Tab Line
    SLactive = { guibg = bg1Soft},
    SLinactive = { gui = 'underline', guisp=DullerYellow },
    SLfilepathsep = { guifg=Comment },
    SLfilepath = { guifg=Yellow, gui='bold' },
    SLlinecolsep = { guifg=Comment },
    SLlinecol = { guifg=Red },
    SLmodified = { guifg=Green },
    SLmodifiedsep = { guifg=Green },
    SLfiletype = { guifg=Red },
    SLfiletypesep = { guifg=Red },

    TL = { guibg = "NONE" },
    TLpre = { guifg=OrangeStrong },
    TLenvsep = { guifg=Guides },
    TLenv = { guifg=Yellow, gui="bold" },
    TLtimesep = { guifg=Guides },
    TLtime = { guifg=OrangeStrong, },
    TLgitsep = { guifg=Guides },
    TLgitorg = { guifg=Yellow },
    TLgitbranch = { guifg=Yellow, gui="bold" },
    TLi3 = { guifg=Yellow, gui="bold" },
    TLi3sep = { guifg=Guides },

    -- Indent blank line
    IndentBlanklineChar = { guifg = Blue },
    IndentBlanklineContextChar = { guifg = Chosen },

    IndentBlanklineContextStart = { guisp=Guides  },
    IndentBlanklineSpaceChar = { guisp=Guides },
    IndentBlanklineSpaceCharBlankline = { guisp=Guides },

    -- Ultest
    UltestPass = { guifg = Pass },
    UltestFail = { guifg = Fail },
    UltestRunning = { guifg = Running },
    UltestBorder = { guifg = Guides },
    UltestSummaryInfo = { guifg = Purple },
    UltestSummaryFile = { guifg = Normal },
    UltestSummaryNamespace = { guifg = Chosen },

    -- Git diffs
    DiffAdd = { guifg = Add, gui="underline", guisp=Add },
    DiffChange= { guifg = Change, gui="underline", guisp=Change },
    DiffDelete = { guifg = Delete, gui="underline", guisp=Delete },
    DiffText = { guifg = Change, gui="underline", guisp=Change  },

}

return self
