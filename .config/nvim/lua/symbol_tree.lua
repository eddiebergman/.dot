local self = {}
local util = require("util")

local config = {
    backend = {"treesitter", "lsp"},
    highlight_closes = true,
    highlight_on_hover = true,
    default_bindings = false,
    default_direction = "prefer_left"
}

local keymaps = { {"<C-l>", "<cmd>AerialToggle<CR>"} }

function self.setup()
    require("aerial").setup(config)
    util.setkeys("n", keymaps)
end

return self
