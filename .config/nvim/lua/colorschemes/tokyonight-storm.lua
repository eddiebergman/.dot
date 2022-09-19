local self = {}
local colors = require("tokyonight.colors").setup({})

self.background = "dark"
self.base = "tokyonight"

vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_sidebars = { "Outline", "calendar", "Trouble", "neotest-summary", "help" }
vim.g.tokyonight_colors = { hint = colors.yellow, error = colors.red1 }

self.highlights = {
    CursorLine = { guibg = "NONE", gui = "underline" },
    Folded = { guifg = colors.orange, gui = "NONE", guibg = "NONE" },
    TSPunctSpecial = { guifg = colors.comment },
    TSPunctBracket = { guifg = colors.comment },

    -- Neotest
    NeotestAdapterName = { guifg = colors.purple, guibg = "NONE" },
    NeotestBorder = { guifg = colors.cyan, guibg = "NONE" },
    NeotestExpandMarker = { guifg = colors.cyan, guibg = "NONE" },
    NeotestDir = { guifg = colors.orange, guibg = "NONE" },
    NeotestFile = { guifg = colors.magenta, guibg = "NONE" },
    NeotestFailed = { guifg = colors.red1, guibg = "NONE" },
    NeotestFocused = { guifg = colors.yellow, guibg = "NONE" },
    NeotestIndent = { guifg = colors.cyan, guibg = "NONE" },
    NeotestMarked = { guifg = colors.cyan, guibg = "NONE" },
    NeotestNamespace = { guifg = colors.cyan, guibg = "NONE" },
    NeotestPassed = { guifg = colors.green, guibg = "NONE" },
    NeotestRunning = { guifg = colors.orange, guibg = "NONE" },
    NeotestWinSelect = { guifg = colors.cyan, guibg = "NONE" },
    NeotestSkipped = { guifg = colors.teal, guibg = "NONE" },
    NeotestTarget = { guifg = colors.cyan, guibg = "NONE" },

    -- Smybols outline
    FocusedSymbol = { guifg = colors.orange, guibg = "NONE" }
}

return self
