local self = {}

local util = require('util')

function self.setup()
    util.setkeys('n', {
        {'T', ':UltestNearest<cr>:UltestSummaryOpen<cr>'},
        {'<leader>tt', ':UltestSummary<cr>'},
        {'<leader>to', ':UltestOutput<cr>'},
    })
end

return self

