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

local pyright_config = {}

local kind = "jedi"

function self.setup()

    if os.getenv("VIRTUAL_ENV") ~= nil and kind == "jedi" then
        require("lspconfig").jedi_language_server.setup({
            on_attach = require('lsp.config').on_attach,
            -- require('virtualtypes').on_attach(client, buffer)
            capabilities = require('lsp.config').capabilities,
            single_file_support = true,
            settings = pyright_config,
            flags = { allow_incremental_sync = false },
        })
    end


end

return self
