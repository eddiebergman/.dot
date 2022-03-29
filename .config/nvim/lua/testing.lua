local self = {}

local util = require('util')

function self.setup()
    util.setkeys('n', {
        {'t', ':UltestNearest<cr>:UltestSummaryOpen<cr>'},
        {'<leader>to', ':UltestOutput<cr>'},
        {'<C-t>', ':UltestSummary<cr>'},
    })
end

return self

