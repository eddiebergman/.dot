local self = {}

vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_background = "hard"
vim.g.everforest_sign_column_background = "none"
vim.g.everforest_ui_contrast = "low"
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_current_word = "bold"

self.background = "dark"
self.base = "everforest"

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

self.highlights = {}

return self
