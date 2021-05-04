-- TODO: Filter out into lua based filetype plugins for syntax highlighting
-- helpers
local function get(a, b)
    if not (a == nil) then return a else return b end
end
local function foreach(t, f)
    for k, v in pairs(t) do f(k, v) end
end

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

local function cmd_highlight(group, args)
    local fg = get(args.fg, Transparent)
    local bg = get(args.bg, Background)
    local attrs = get(args.attr, "none")
    local sp = get(args.sp, "none")
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " gui=" .. attrs .. " guisp=" .. sp)
end

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

foreach(highlights, cmd_highlight)
