local self = {}
local neotest = require("neotest")

local util = require('util')

self.keymaps = {
    n = {
        {"T", "<cmd>lua require('neotest').summary.toggle()<CR>"},
        {"tt", "<cmd>lua require('neotest').run.run()<CR>"},
        {"to", "<cmd>lua require('neotest').output.open({enter = true, short = true})<CR>"},
        {"tT", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>"},
        {"ts", "<cmd>lua require('neotest').run.stop()<CR>"},
    }
}

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end

    neotest.setup({
        adapters = {
            require("neotest-python")({
                args = {"--log-level", "DEBUG", "--color", "yes"}
            })
        }
    })
end

return self

