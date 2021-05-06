local M = {}

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
local highlights = {
    -- Base Syntax Types
    Structure = { guifg = DullYellow, gui="bold" },
    Type = { guifg = DullYellow },
    Todo = { guifg = SkyBlue, gui="bold" },
    Identifier = { guifg = Red },
    --TODO:
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
}

-- ====================
-- Apply the highlights
-- ====================
-- These are applied on buffer load to enable overwriting of any colorscheme
-- settings.
local function cmd_highlight(group, args)
    local strbuf = { "hi "..group }
    for k, v in pairs(args) do
        table.insert(strbuf, k..'='..v)
    end
    vim.cmd(table.concat(strbuf, ' '))
end

function M.apply_highlights()
    foreach(highlights, cmd_highlight)
end

vim.cmd [[
augroup Highlight
    au!
    au ColorScheme * lua require('colors').apply_highlights()
augroup End
]]
return M
