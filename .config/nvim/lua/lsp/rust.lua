local self = {}

function self.setup()
    require("lspconfig").rust_analyzer.setup({})
end

return self
