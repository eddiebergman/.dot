local self = {}

function self.setup()
    local luadev = require("neodev").setup()
    local lspconfig = require('lspconfig')
    lspconfig.sumneko_lua.setup(luadev)
end

return self
