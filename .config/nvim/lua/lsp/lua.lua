local self = {}

function self.setup()
    local luadev = require("lua-dev").setup({
        library = {
            vimruntime = true,
            plugins = { "nvim-treesitter", "null-ls", }, -- "pyrate.nvim" },
            types = true,
        },
        settings = {
            Lua = {
                IntelliSense = { traceLocalSet = true },
                diagnostics = { globals = { "vim" }, },
            },
        },
    })

    local lspconfig = require('lspconfig')
    lspconfig.sumneko_lua.setup(luadev)
end

return self
