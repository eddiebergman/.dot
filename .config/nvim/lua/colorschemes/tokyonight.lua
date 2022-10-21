local self = {}

function self.setup()
    require("tokyonight").setup({
        style = "tokyonight-night",
        sidebars = { "Outline", "calendar", "Trouble", "neotest-summary", "help", "Codewindow"},
        hide_inactive_statusline = true,

        on_colors = function(colors)
            colors.hint = colors.yellow
            colors.error = colors.red1
        end,

        on_highlights = function(hl, c)
            hl.Folded = { fg = c.orange }
            hl.CursorLine = { bg = c.bg_highlight }
            hl.Delimiter = { fg = c.comment, bg = c.bg_highlight }

            hl.BufferlineFill = { bg=c.bg_dark }
            hl.NormalFloat = { bg=c.bg_highlight }
            hl.FloatBorder = { bg=c.bg, fg=c.magenta2 }
            hl.CodewindowBorder = { bg=c.bg_dark, fg=c.white }
            hl.TSType = { fg=c.cyan }

            hl["@punctuation.bracket"] = { fg = c.comment }
            hl["@punctuation.delimiter"] = { fg = c.cyan }
            hl["@punctuation.special"] = { fg = c.comment }
            hl['@keyword'] = { fg = c.magenta}
            hl['@keyword.function'] = { fg = c.magenta, italic = true}
            hl['@keyword.operator'] = { fg = c.magenta, italic = false }
            hl['@keyword.return'] = { fg = c.magenta }
            hl['@conditional'] = { fg = c.magenta }
            hl['@repeat'] = { fg = c.magenta }
            hl['@exception'] = { fg = c.magenta }
            hl['@function.builtin'] = { fg = c.cyan, italic = true }
            hl['@operator'] = { fg = c.cyan }
            hl['@constructor'] = { fg = c.magenta, bold = true }
            -- self
            hl['@variable.builtin.python'] = { fg = c.red, italic = false }
        end,
    })
end

return self
