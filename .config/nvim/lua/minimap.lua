local codewindow = require("codewindow")
local winapi = require("codewindow.window")
local commands = require("commands")


local M = {}

function M.enter()
    local window = winapi.get_minimap_window()
    if window ~= nil and window.focused then
        return
    end

    local open = winapi.is_minimap_open()
    if not open then
        codewindow.open_minimap()
    end

    winapi.set_focused(true)
end

function M.test()
end

function M.exit(close)
    if close == nil then
        close = false
    end

    local window = winapi.get_minimap_window()
    if window ~= nil and window.focused then
        winapi.set_focused(false)
    end

    if close and winapi.is_minimap_open() then
        winapi.close_minimap()
    end
end

function M.setup()
    codewindow.setup({
        minimap_width = 20, -- The width of the text part of the minimap
        width_multiplier = 1, -- How many characters one dot represents
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        exclude_filetypes = { "NvimTree", "help", "Trouble" }, -- Choose certain filetypes to not show minimap on
        z_index = 50, -- The z-index the floating window will be on
        max_minimap_height = 30, -- The maximum height the minimap can take (including borders)
    })

    commands.register({
        name = "MinimapEnter",
        cmd = "lua require('minimap').enter()",
        key = "<C-l>"
    })

end

return M
