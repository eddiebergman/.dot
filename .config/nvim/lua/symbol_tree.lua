local self = {}
local util = require("util")

function self.setup()
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = false,
        auto_preview = false,
        position = 'left',
        relative_width = false,
        width = 40,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = false,
        preview_bg_highlight = 'search',
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {"<C-l>", "q"},
            goto_location = "l",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
        },
        lsp_blacklist = {},
        symbol_blacklist = { "Module", "Variable" },
        symbols = {
            File = {icon = "", hl = "TSURI"},
            Module = {icon = "", hl = "TSNamespace"},
            Namespace = {icon = "", hl = "TSNamespace"},
            Package = {icon = "", hl = "TSNamespace"},
            Class = {icon = "𝓒", hl = "TSBoolean"},
            Method = {icon = "ƒ", hl = "TSString"},
            Property = {icon = "", hl = "TSMethod"},
            Field = {icon = "", hl = "TSField"},
            Constructor = {icon = "", hl = "TSConstructor"},
            Enum = {icon = "ℰ", hl = "TSType"},
            Interface = {icon = "ﰮ", hl = "TSType"},
            Function = {icon = "", hl = "TSString"},
            Variable = {icon = "", hl = "TSConstant"},
            Constant = {icon = "", hl = "TSConstant"},
            String = {icon = "𝓐", hl = "TSString"},
            Number = {icon = "#", hl = "TSNumber"},
            Boolean = {icon = "⊨", hl = "TSBoolean"},
            Array = {icon = "", hl = "TSConstant"},
            Object = {icon = "⦿", hl = "TSType"},
            Key = {icon = "🔐", hl = "TSType"},
            Null = {icon = "NULL", hl = "TSType"},
            EnumMember = {icon = "", hl = "TSField"},
            Struct = {icon = "𝓢", hl = "TSType"},
            Event = {icon = "🗲", hl = "TSType"},
            Operator = {icon = "+", hl = "TSOperator"},
            TypeParameter = {icon = "𝙏", hl = "TSParameter"}
        }
    }
    util.setkey("<C-s>" , "zR:SymbolsOutline<cr>")
end

return self
