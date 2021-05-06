local util = require('util')
local get = util.get
local foreach = util.foreach
local has = vim.fn['has']

-- ===========
-- Colors opts
-- ===========
-- Colorscheme
vim.cmd [[ colo stellarized ]]
vim.o.background = 'dark'

-- ============
-- Checks
-- ============
if has("termguicolors") then vim.o.termguicolors = true end
if has("nvim") then vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 end

-- =======
-- Colours
-- =======
local Transparent = "NONE"
local DullYellow = "#a58949"
local Grey = "#9d8875"
local Violet = "#D484FF"
local Blue = "#2f628e"
local SkyBlue = "#4c73c2"
local Cyan = "#00f1f5"
local Green = "#5c9a61"
local Green2 = "#2f7366"
local Yellow = "#FFF59D"
local Orange = "#F79000"
local Pink = '#c75ad8'
local Red = "#ca7375"
local FloatBackground = "#132434"
local Background = "NONE"

-- ==================
-- Specify Highlights
-- ==================
highlights = {
    -- Base Syntax Types
    Structure = { fg = DullYellow, attr="bold" },
    Type = { fg = DullYellow },
    Todo = { fg = SkyBlue, attr="bold" },
    Identifier = { fg = Red },

    -- Lsp
    LspDiagnosticsDefaultError = { fg = Red },
    LspDiagnosticsUnderlineError = { attr="undercurl", sp = Red },

    LspDiagnosticsDefaultWarning = { fg = Orange },
    LspDiagnosticsUnderlineWarning= { attr="undercurl", sp = Orange },

    LspDiagnosticsDefaultInformation = { fg = Grey },
    LspDiagnosticsUnderlineInformation= { attr="undercurl", sp = Grey },

    LspDiagnosticsDefaultHint = { fg = Grey },
    LspDiagnosticsUnderlineHint= { attr="undercurl", sp = Grey },

    -- Editor
    CursorLineNr = { fg = Grey, attr="bold" },
    LineNr = { fg = Grey },
}

local function cmd_highlight(group, args)
    local fg = get(args.fg, Transparent)
    local bg = get(args.bg, Background)
    local attrs = get(args.attr, "none")
    local sp = get(args.sp, "none")
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " gui=" .. attrs .. " guisp=" .. sp)
end

foreach(highlights, cmd_highlight)
