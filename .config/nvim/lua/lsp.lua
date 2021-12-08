local self = {}
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

local visual_keymaps = {

}


-- =====================
-- Language Server Setup
-- =====================
local on_attach = function(client, bufnr)
    print(string.format("%s is active", client.name))

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

    -- Part of cmp
    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    print(os.getenv('VIRTUAL_ENV')..'/bin/pylsp')
    lsp.pylsp.setup({
        cmd = {
            os.getenv('VIRTUAL_ENV')..'/bin/pylsp',
            '-vvv',
            '--log-file', '/home/skantify/.dot/.config/nvim/tmp/pylsp.log'
        },
        filetypes = {"python"},
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = true,
        settings = {
            pylsp = {
                configurationSources = {'flake8'},
                plugins = {
                    mccabe = { enabled = false },
                    flake8 = { enabled = true, },
                    pycodestyle = { enabled = false },
                    pylint = { enabled = true },
                    rope_complete = { enabled = false },
                    pyflakes = { enabled = true },
                    yapf = { enabled = false },
                    pydocstyle = { enabled = true },
                    jedi_completion = { enabled = true },
                    mypy = {
                        enabled = true,
                        dmypy = true,
                        live_mode = false,
                        strict = false,
                    },
                }
            }
        }
    })
end

function self.setup()
    util.setkeys('n', normal_keymaps)
end

return self
