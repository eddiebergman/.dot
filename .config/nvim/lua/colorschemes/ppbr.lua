-- =======
-- Colours
-- =======
local DullYellow = "#a5894A"
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

local highlights = {
    -- Base Syntax Types
    Structure = { guifg = DullYellow, gui="bold" },
    Type = { guifg = DullYellow },
    Todo = { guifg = SkyBlue, gui="bold" },
    Identifier = { guifg = Red },

    -- Lsp
    LspDiagnosticsDefaultError = { guifg = Red },
    LspDiagnosticsUnderlineError = { gui="undercurl", guisp = Red },

    LspDiagnosticsDefaultWarning = { guifg = Orange },
    LspDiagnosticsUnderlineWarning= { gui="undercurl", guisp = Orange },

    LspDiagnosticsDefaultInformation = { guifg = Grey },
    LspDiagnosticsUnderlineInformation= { gui="undercurl", guisp = Grey },

    LspDiagnosticsDefaultHint = { guifg = Grey },
    LspDiagnosticsUnderlineHint= { gui="undercurl", guisp = Grey },

    -- Editor
    CursorLineNr = { guifg = Grey, gui="bold" },
    LineNr = { guifg = Grey },

    -- Tree Sitter (General)
    TSVariableBuiltin = { guifg = White, gui="bold" },
    TSConstant = { guifg = Red, gui="nocombine,NONE" },
    TSType = { guifg = Violet, gui="NONE" },
    TSKeyword = { guifg = SkyBlue },
    TSVariable = { guifg = White },
    TSProperty = { guifg = White },
    TSParameter = { guifg = White },
    TSConditional = { guifg = SkyBlue },
    TSRepeat = { guifg = SkyBlue },
    TSString = { guifg = Grey },
    TSKeywordOperator = { guifg = SkyBlue },
    TSOperator = { guifg = DarkerGrey },
    TSMethod = { guifg = DarkerCyan },
    TSFuncBuiltin = { guifg = Violet, gui = "nocombine,NONE"},
    TSFunction = { guifg = Red, gui="NONE" },
    TSPunctBracket = { guifg = DarkerGrey },
    TSPunctDelimiter = { guifg = DarkerGrey },
    TSField = { guifg = White },
    TSConstructor = { guifg = Red, gui="nocombine,NONE" },
    TSConstBuiltin = { guifg = BrighterViolet, gui="NONE" },
    TSPunctSpecial = { guifg = BrighterViolet },
    TSNumber = { guifg = DullYellow },
    TSComment = { guifg = DarkerGrey, gui="italic" },
    TSInclude = { guifg = BrighterViolet },
    TSKeywordFunction = { guifg = SkyBlue }

}

return highlights
