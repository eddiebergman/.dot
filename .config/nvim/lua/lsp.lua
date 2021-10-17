-- TODO: Get code formatting for Python to work
local lsp = require('lspconfig')
local util = require('util')

-- =======
-- Keymaps
-- =======
-- Get's called upon set in buffer upon loading an lsp local
local normal_keymaps = {

    -- [g]o [d]efinition
    {"gd", "<cmd>lua vim.lsp.buf.definition()<CR>"},

    -- [r]ename
    {"<leader>r" , "<cmd>lua vim.lsp.buf.rename()<CR>"},

    -- [f]ind
    {"<leader>f" ,"<cmd>lua vim.lsp.buf.references()<CR>"},

    -- [g]o [t]ype
    {"<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>"},

    -- [s]how [d]oc
    {"<leader>sd", "<cmd>lua vim.lsp.buf.signature_help()<CR>"},

    -- [s]how [h]over
    -- Note: not sure what's this is meant to show but not present in present in
    --        pyright
    --{"<leader>sh" , "<cmd>lua vim.lsp.buf.hover()<CR>"},

    -- next [a
    {"[a", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},

    -- prev ]a
    {"]a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},

    -- [c]ode [a]ctions
    {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"},

    -- [s]how [e]rrors
    {"<leader>se", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
}

-- ========
-- Handlers
-- ========
local default_handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = False,
            signs = True,
            underline = True,
        }
    )
}

-- =====================
-- Language Server Setup
-- =====================
local on_attach = function(client, bufnr)
    print(string.format("%s is active", client.name))
    util.setkeys('n', normal_keymaps, bufnr)


    -- If autocommands wanted
    -- vim.api.nvim_exec([[
    --    augroup LspAutocommands
    --        autocmd! * <buffer>
    --    augroup END
    --]], true)
end

lsp.pylsp.setup({
    cmd = { "/home/skantify/.pyenv/versions/3.8.5/bin/pylsp" },
    on_attach = on_attach,
    settings = {
        pylsp = {
            configurationSources = {'flake8'},
            plugins = {
                flake8 = {
                    enabled = true,
                    hangClosing = false,
                    maxLineLength = 100
                },
                pycodestyle = {
                    enabled = false
                },
                pydocstyle = {
                    enabled = true
                },
                mypy = {
                    enabled = true,
                    dmypy = true,
                    live_mode = false
                }
            }
        }
    }
})
