local self = {}

function self.setup()

    require("lspconfig").jedi_language_server.setup({
        on_attach = require('lsp.config').capabilities,
        capabilities = require('lsp.config').capabilities,
        single_file_support = true,
        filetypes = { "python" },
        init_options = {
            markupKindPreferred = "markdown"
        }
    })


end

return self
