-- TODO: Get code formatting for Python to work
local lsp = require('lspconfig')
local util = require('util')

-- =======
-- Keymaps
-- =======
-- Get's called upon set in buffer upon loading an lsp local
local normal_keymaps = {
    -- [r]ename
    {"<leader>r" , "<cmd>lua vim.lsp.buf.rename()<CR>"},

    -- find [u]sage
    {"<leader>u" ,"<cmd>lua vim.lsp.buf.references()<CR>"},

    -- [f]ormat
    {"<leader>f" ,"<cmd>lua vim.lsp.buf.formatting()<CR>"},

    -- [s]how [d]efintion
    {"<leader>sd", "<cmd>lua vim.lsp.buf.hover()<CR>"},

    -- next [a
    {"[a", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},

    -- prev ]a
    {"]a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},

    -- [c]ode [a]ctions
    {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"},

    -- [e]rror
    {"<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
}

-- ========
-- Handlers
-- ========
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- =====================
-- Language Server Setup
-- =====================
local on_attach = function(client, bufnr)
    print(string.format("%s is active", client.name))
    util.setkeys('n', normal_keymaps, bufnr)

    local border = {
        {"🭽", "FloatBorder"},
        {"▔", "FloatBorder"},
        {"🭾", "FloatBorder"},
        {"▕", "FloatBorder"},
        {"🭿", "FloatBorder"},
        {"▁", "FloatBorder"},
        {"🭼", "FloatBorder"},
        {"▏", "FloatBorder"},
    }


    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = true,
        }
    )
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border=border }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border=border }
    )
end

if os.getenv("VIRTUAL_ENV") ~= nil then

    lsp.pylsp.setup({
        cmd = { os.getenv('VIRTUAL_ENV')..'/bin/pylsp' },
        on_attach = on_attach,
        default_handlers = default_handlers,
        settings = {
            pylsp = {
                configurationSources = {'flake8'},
                plugins = {
                    flake8 = {
                        enabled = true,
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
end
