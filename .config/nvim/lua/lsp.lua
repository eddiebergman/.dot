local M = {}
local lspconfig = require("lspconfig")

local above_below_border = { "▔", "▔", "▔", " ", "▁", "▁", "▁", " " }
local capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.setup()
    vim.diagnostic.config({
        virtual_text = { severity = vim.diagnostic.severity.ERROR },
        signs = { severity = { max = vim.diagnostic.severity.WARN } },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = { "▔", "▔", "▔", " ", "▁", "▁", "▁", " " },
            source = "always",
            header = "",
            prefix = "",
        }
    })
    -- M.show_diagnostics_on_hover()
    M.enable_markdown_highlighting_in_lsp_hover()
    -- Just makes the lua lsp a bit smarter
    require("neodev").setup({
        library = {
            vimruntime = true,
            types = true,
            plugins = true,
            -- Manually add the neovim runtime
            -- [vim.fn.stdpath("config") .. "/lua"] = true,
        },
    })

    local lsp_servers = require("config/mason").lsp_servers
    for _, server in ipairs(lsp_servers) do

        -- Special setup for some servers like pyright where I know a bit more
        if server == "pyright" then
            lspconfig[server].setup({
                settings = {
                    pyright = {
                        disableOrganizeImports = true, -- Will use ruff instead
                    },
                    python = {
                        analysis = {
                            autoImportCompletions = true,
                            diagnosticMode = "openFilesOnly",  -- Use "workspace" if you like but may be slow
                            typeCheckingMode = "basic", -- Using Mypy instead, it's better
                            pythonPath = "python", -- gets replaced below
                        }
                    },
                },
                before_init = function(_, config)
                    local penv = require("util").python_env({ patterns = { "venv", ".venv", "env", ".env" } })
                    if penv == nil then
                        return
                    end
                    config.settings.python.pythonPath = penv.python
                end,
                capabilities = capabilities,
                on_attach = M.breadcrumbs_attach,
            })
        elseif server == "sumneko_lua" then
            lspconfig[server].setup({
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        telemetry = { enable = false },
                    }
                }
            })
        else
            lspconfig[server].setup({
                capabilities = capabilities,
                on_attach = M.breadcrumbs_attach,
            })
        end
    end
end

function M.breadcrumbs_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

function M.show_diagnostics_on_hover()
    vim.api.nvim_create_autocmd(
        "CursorHold",
        { callback = function() vim.diagnostic.open_float() end }
    )
end

function M.enable_markdown_highlighting_in_lsp_hover()
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        local f = vim.lsp.with(vim.lsp.handlers.hover, {
            border = above_below_border,
            stylize_markdown = false
        })
        local floating_bufnr, floating_winnr = f(err, result, ctx, config)
        vim.api.nvim_buf_set_option(floating_bufnr, "filetype", "markdown")
        return floating_bufnr, floating_winnr
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = above_below_border }
    )
end

return M
