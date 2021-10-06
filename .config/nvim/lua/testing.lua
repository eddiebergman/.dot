local self = {}

local util = require('util')

function self.setup()
    util.setkeys('n', {
        {'<leader>tf', ':Ultest<cr>:UltestSummaryOpen<cr>'},
        {'<leader>tt', ':UltestNearest<cr>:UltestSummaryOpen<cr>'},
        {'<leader>ts', ':UltestSummary<cr>'},
        {'<leader>to', ':UltestOutput<cr>'},
    })
end

return self

