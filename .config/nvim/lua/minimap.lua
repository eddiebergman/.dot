local codewindow = require("codewindow")
local commands = require("commands")

local M = {}

function M.setup()
    codewindow.setup({
        minimap_width = 20, -- The width of the text part of the minimap
        width_multiplier = 2, -- How many characters one dot represents
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        exclude_filetypes = {}, -- Choose certain filetypes to not show minimap on
        z_index = 50, -- The z-index the floating window will be on
        max_minimap_height = 30, -- The maximum height the minimap can take (including borders)
    })

    commands.register({
        name = "Minimap",
        cmd = "lua require('codewindow').toggle_minimap()",
        key = "<leader>mm"
    })

    commands.register({
        name = "MinimapFocus",
        cmd = "lua require('codewindow').toggle_focus()",
        key = "<C-l>"
    })
end

return M
