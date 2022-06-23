local self = {}


function self.setup()
    require("lspconfig").bashls.setup{}
end

return self
