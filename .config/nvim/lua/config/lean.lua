local util = require('util')
local on_attach = require('lsp').on_attach

-- Check for the lean language server
if util.executable('lean-language-server') then
    require('lean').setup({
        abbreviations = { compe = true },
        mapping = true,
        infoview = { maxwidth = 48 },
        lsp = {
            cmd = {'lean-language-server', '--stdio'},
            on_attach = on_attach,
        }
    })
else
    print([[
        Attempted to load lean language server but could not find it

            npm install -g lean-language-server

    ]])

end
