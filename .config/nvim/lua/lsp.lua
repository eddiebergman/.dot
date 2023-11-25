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
                            autoSearchPaths = true,
                            autoImportCompletions = true,
                            diagnosticMode = "openFilesOnly", -- Use "workspace" if you like but may be slow
                            typeCheckingMode = "basic",   -- Using Mypy instead, it's better
                            pythonPath = "python",        -- gets replaced below
                        }
                    },
                },
                before_init = function(_, config)
                    local penv = require("util").python_env({
                        patterns = { "venv", ".venv", "env", ".env", ".eddie-venv" }
                    })
                    if penv == nil then
                        return
                    end
                    config.settings.python.pythonPath = penv.python
                end,
                capabilities = capabilities,
            })
        elseif server == "ruff_lsp" then
            lspconfig[server].setup({
                -- Handled by Pyright
                on_attach = function(client, _)
                    client.server_capabilities.hoverProvider = false
                end,
                commands = {
                    RuffOrganizeImports = {
                      function()
                        vim.lsp.buf.execute_command {
                          command = 'ruff.applyAutofix',
                          arguments = { { uri = vim.uri_from_bufnr(0) } },
                        }
                      end,
                      description = 'Ruff: Fix all auto-fixable problems',
                    },
                },
                capabilities = capabilities,
            })
        elseif server == "lua_ls" then
            lspconfig[server].setup({
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        telemetry = { enable = false },
                    }
                },
                capabilities = capabilities,
            })
        else
            lspconfig[server].setup({
                capabilities = capabilities,
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
            stylize_markdown = false,
        })
        local floating_bufnr, floating_winnr = f(err, result, ctx, config)
        local text = vim.api.nvim_buf_get_lines(floating_bufnr, 0, -1, false)
        -- Replace all occurences of '&nbsp;&nbsp;&nbsp;&nbsp;' with '* '
        for i, line in ipairs(text) do
            text[i] = line:gsub("&nbsp;&nbsp;&nbsp;&nbsp;(%w+):", "* [%1] ")
            text[i] = text[i]:gsub("&nbsp;", " ")
            text[i] = text[i]:gsub("\\%[", "[")
            text[i] = text[i]:gsub("\\%]", "]")
        end
        vim.api.nvim_buf_set_option(floating_bufnr, "modifiable", true)
        vim.api.nvim_buf_set_lines(floating_bufnr, 0, -1, false, text)
        vim.api.nvim_buf_set_option(floating_bufnr, "modifiable", false)
        vim.api.nvim_buf_set_option(floating_bufnr, "filetype", "markdown")
        return floating_bufnr, floating_winnr
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = above_below_border }
    )
end

return M
