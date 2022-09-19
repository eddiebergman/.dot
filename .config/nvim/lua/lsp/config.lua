local self = {}
local util = require('util')
local _ = require("py")

local normal_keymaps = {
    -- [r]ename
    {"<leader>r" , "<cmd>lua vim.lsp.buf.rename()<CR>"},

    -- [f]ormat
    {"<leader>f" , "<cmd>lua vim.lsp.buf.formatting()<CR>"},

    -- [s]how [d]efintion
    {"<leader>sd", "<cmd>lua vim.lsp.buf.hover()<CR>"},


    -- [c]ode [a]ctions
    {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"},

    -- [e]rror
    {
        "<leader>e",
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>'
    },

    -- next [a
    {
        "[a",
        '<cmd>lua vim.lsp.diagnostic.goto_next({ border = "rounded" })<CR>'
    },

    -- prev ]a
    {
        "]a",
        '<cmd>lua vim.lsp.diagnostic.goto_prev({ border = "rounded" })<CR>'
    },

    {
        "<leader>dlsp",
        "<cmd>lua require('lsp.debug').debug()<CR>"
    },
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
    util.setkeys("n", normal_keymaps)

    vim.diagnostic.config(self.config)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border = "rounded", }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = "rounded" }
    )

    for module in _.list({"python", "lua", "null_ls", "bash", "rust"}) do
        require("lsp."..module).setup()
    end
end

-- We ensure that nvim-cmp is setup and updated capabilities
self.capabilities = require('completion').capabilities


return self
