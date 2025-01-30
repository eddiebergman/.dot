local M = {}

M.lsp_servers = {
    "bashls", -- bash
    "yamlls", -- yaml
    "taplo", -- toml
    "esbonio", -- rst docs
    "marksman", -- markdown
    "lua_ls", -- lua
    "pyright", -- python
    "ruff", -- python
    "jsonls", -- json
    "clangd", -- c/c++
    "zls", -- zig
    -- Handled by rustaceanvim
    -- "rust-analyzer", -- rust
}

function M.register_lsp_keys(args)
    local telescope = require("telescope.builtin")
    local opts = { buffer = true, silent = true }

    vim.keymap.set("n", "cc", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "sd", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gl", function()
        telescope.lsp_definitions({ jump_type = "vsplit" })
    end, opts)
    vim.keymap.set("n", "se", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "sr", function()
        telescope.lsp_references()
    end, opts)
    if vim.bo.filetype == "rust" then
        vim.keymap.set("n", "<A-cr>", ":RustLsp codeAction<cr>", opts)
    else
        vim.keymap.set("n", "<A-cr>", function()
            vim.lsp.buf.code_action()
        end, opts)
    end
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "gi", function()
        telescope.lsp_implementations()
    end, opts)
    vim.keymap.set("n", "<leader>ti", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)
    vim.keymap.set("n", "<leader>td", function()
        vim.diagnostic.setqflist()
    end, opts)
end

local virtual_text = {
    severity = { vim.diagnostic.severity.ERROR },
    suffix = "",
    prefix = "",
    hl_mode = "blend",
}

M.diagnostic_config = {
    virtual_text = false,
    signs = {
        severity = { max = vim.diagnostic.severity.ERROR },
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "none", -- { " ", " ", " ", " ", " ", "─", " ", " " },
        padding = { 0, 0 },
        source = "always",
        header = "",
        format = function(diagnostic)
            if diagnostic.message == nil then
                return " No Message "
            end
            local msg = diagnostic.message
            if diagnostic.code == nil then
                return " " .. msg .. " "
            end
            return " [" .. diagnostic.code .. "] " .. msg .. " "
        end,
        suffix = "",
        prefix = "",
    },
}

function M.setup()
    local lspconfig = require("lspconfig")
    vim.diagnostic.config(M.diagnostic_config)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason").setup({
        PATH = "append", -- Ensure we prefer local binaries where possible
    })

    local lsp_augroup = vim.api.nvim_create_augroup("LspGroup", {})
    vim.api.nvim_create_autocmd(
        "LspAttach",
        { callback = M.register_lsp_keys, group = lsp_augroup }
    )

    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                lspconfig[server_name].setup({ capabilities = capabilities })
            end,
        },
    })

    -- Setup some custom LSP
    -- lspconfig.tsserver.setup({ capabilities = capabilities })
    -- lspconfig.tailwindcss.setup({ capabilities = capabilities })
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                telemetry = { enable = false },
            },
        },
    })
    lspconfig.ruff.setup({
        on_attach = function(client, _)
            -- Handled by Pyright
            client.server_capabilities.hoverProvider = false

            -- Apply ruff auto fix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        filter = function(action)
                            return action.title == "Ruff: Fix All"
                        end,
                    })
                end,
            })
        end,
        before_init = function(_, config)
            local penv = require("util").python_env({
                patterns = { "venv", ".venv", "env", ".env", ".eddie-venv" },
            })
            if penv == nil then
                return
            end
            config.settings.interpreter = penv.python
        end,
    })
    lspconfig.zls.setup({
        capabilities = capabilities,
        settings = { zls = { enable_build_on_save = false } },
    })
    lspconfig.pyright.setup({
        settings = {
            pyright = { disableOrganizeImports = true },
            python = {
                analysis = {
                    autoSearchPaths = true,
                    autoImportCompletions = true,
                    diagnosticMode = "openFilesOnly", -- Use "workspace" if you like but may be slow
                    typeCheckingMode = "basic", -- Using Mypy instead, it's better
                    pythonPath = "python", -- gets replaced below
                },
            },
        },
        before_init = function(_, config)
            local penv = require("util").python_env({
                patterns = { "venv", ".venv", "env", ".env", ".eddie-venv" },
            })
            if penv == nil then
                return
            end
            config.settings.python.pythonPath = penv.python
        end,
    })
end

return M
