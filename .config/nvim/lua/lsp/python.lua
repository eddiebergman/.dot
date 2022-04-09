local self = {}

local pylsp_config = {
    pylsp = {
        configurationSources = { "flake8" },
        plugins = {
            mccabe = { enabled = false },
            pydocstyle = { enabled = true },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
            mypy = { enabled = false }, -- Using null-ls instead, seems more responsive
            yapf = { enabled = false },
        }
    }
}

function self.setup()

    if os.getenv("VIRTUAL_ENV") ~= nil then
        require("lspconfig").pylsp.setup({
            on_attach = require('lsp.config').on_attach,
            capabilities = require('lsp.config').capabilities,
            single_file_support = true,
            settings = pylsp_config,
            flags = {
                allow_incremental_sync = false
            },
        })
    end


end


return self
