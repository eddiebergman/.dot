local self = {}
-- Mainly relies on nvim/telescope
--
local util = require('util')

self.keymaps = {
    n = {
        -- [g]o [D]efinition (Goes to any found definition in the workspace)
        {'gD', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>' },

        -- [g]o [d]eclaration
        {'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>' },
    }
}

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end
end

return self
