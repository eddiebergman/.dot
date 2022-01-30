local self = {}
local neogen = require("neogen")
local util = require("util")

local keymaps = {
    {"<leader>dg", ":lua require('neogen').generate()<cr>"}
}

function self.setup()
    neogen.setup({
        enabled = true,
        languages = {
            python = {
                template = {
                    annotation_convention = "numpydoc"
                }
            }
        }
    })
    util.setkeys("n", keymaps)
end

return self
