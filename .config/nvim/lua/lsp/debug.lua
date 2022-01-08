local self = {}

local lsp = require("lsp")

function self.debug()
    print(vim.fn.bufnr())
    print(vim.inspect(vim.))
end

return self
