local self = {}
local util = require("util")

function self.setup()
    local opts = {
        highlight_hovered_item = false,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = 5,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = { "<Esc>", "q" },
            goto_location = {"L", "<LeftMouse>"},
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "h",
            unfold = "l",
            fold_all = "H",
            unfold_all = "E",
            fold_reset = "R",
        },
        lsp_blacklist = { "Module" },
        symbol_blacklist = { "Module" },
        symbols = {
            File = { icon = "", hl = "" },
            Module = { icon = "", hl = "" },
            Namespace = { icon = "", hl = "" },
            Package = { icon = "", hl = "" },
            Class = { icon = "𝓒", hl = "@type" },
            Method = { icon = "ƒ", hl = "@method" },
            Property = { icon = "", hl = "@field" },
            Field = { icon = "", hl = "@field" },
            Constructor = { icon = "", hl = "@constructor" },
            Enum = { icon = "ℰ", hl = "@field" },
            Interface = { icon = "ﰮ", hl = "@constructor" },
            Function = { icon = "", hl = "@function" },
            Variable = { icon = "", hl = "@variable" },
            Constant = { icon = "", hl = "@constant" },
            String = { icon = "𝓐", hl = "@string" },
            Number = { icon = "#", hl = "@number" },
            Boolean = { icon = "⊨", hl = "@boolean" },
            Array = { icon = "", hl = "@constant" },
            Object = { icon = "⦿", hl = "@variable" },
            Key = { icon = "", hl = "@variable" },
            Null = { icon = "NULL", hl = "@constant.builtin" },
            EnumMember = { icon = "", hl = "@field" },
            Struct = { icon = "𝓢", hl = "@constructor" },
            Event = { icon = "🗲", hl = "@variable" },
            Operator = { icon = "+", hl = "@operator" },
            TypeParameter = { icon = "𝙏", hl = "@parameter" }
        }
    }
    util.setkey("<C-s>", "zR:SymbolsOutline<cr>")
    require("symbols-outline").setup(opts)
end

return self
