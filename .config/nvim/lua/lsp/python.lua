local self = {}

function self.setup()

    if os.getenv("VIRTUAL_ENV") ~= nil then
        require("lspconfig").jedi_language_server.setup({
            on_attach = require('lsp.config').capabilities,
            capabilities = require('lsp.config').capabilities,
            single_file_support = true,
            filetypes = { "python" }
            -- settings = {},
        })
    end


end

return self
