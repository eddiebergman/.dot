local self = {}
local util = require('util')
local commands = require("commands")
local _ = require("py")


local format = {
    name = "Format",
    cmd = "lua vim.lsp.buf.format({ async = true})",
    key = "<leader>f",
}

local rename = {
    name = "RenameSymbol",
    cmd = "lua vim.lsp.buf.rename()",
    key = "<leader>r",
}

local show_definition = {
    name = "Definition",
    cmd = "lua vim.lsp.buf.hover()",
    key = "<leader>sd",
}

local code_action = {
    name = "CodeActions",
    cmd =  "lua vim.lsp.buf.code_action()",
    key = "<leader>ca",
}

local show_error = {
    name = "LineError",
    cmd = 'lua vim.diagnostic.open_float({ border = "rounded" })',
    key = "<leader>e",
}

self.config = {
    virtual_text = true, -- { spacing=0, prefix="", format = function(diag) return "●" end },
    update_in_insert = false,
    underline = false,
    signs = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
}

function self.setup()
    vim.diagnostic.config(self.config)

    for _, cmd in ipairs {format, rename, show_definition, code_action, show_error} do
        commands.register(cmd)
    end

    local above_below_border = { "▁", "▁", "▁", " ", "▔", "▔", "▔", " " }
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        local f = vim.lsp.with(
            vim.lsp.handlers.hover, { border = above_below_border, stylize_markdown = false  }
        )
        local floating_bufnr, floating_winnr = f(err, result, ctx, config)
        vim.api.nvim_buf_set_option(floating_bufnr, 'filetype', "markdown")
        return floating_bufnr, floating_winnr
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = above_below_border }
    )

    for module in _.list({ "python", "lua", "null_ls", "bash", "rust" }) do
        require("lsp." .. module).setup()
    end
end

-- We ensure that nvim-cmp is setup and updated capabilities
self.capabilities = require('completion').capabilities

return self
