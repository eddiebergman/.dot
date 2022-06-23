local self = {}

function self.setup()
    require("lspconfig").sumneko_lua.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    })
end

return self
