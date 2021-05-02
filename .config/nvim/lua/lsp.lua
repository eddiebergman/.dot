-- TODO: Get code formatting for Python to work
local lsp = require('lspconfig')

local execute = vim.api.nvim_exec
local setkey = vim.api.nvim_buf_set_keymap

-- Whether to show the virtual text beside the lines
local show_virtual_text = false

function get(a, b)
    if not a == nil then return a else return b end
end

-- Keymappings
local default_opts = { silent = true , noremap = true }

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
    {"[a"        , "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},

    -- prev ]a
    {"]a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},

    -- [c]ode [a]ctions
    {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"},

    -- [s]how [e]rrors
    {"<leader>se", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
}

-- handlers
local default_handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = show_virtual_text
        }
    )
}

local on_attach = function(client, bufnr)
    print('LSP started')

    for _, mapping in pairs(normal_keymaps) do
        keys = mapping[1]
        command = mapping[2]
        opts = get(mapping[3], default_opts)
        setkey(bufnr, "n", keys, command, opts)
    end

    -- If autocommands wanted
    --execute([[
    --    augroup LspAutocommands
    --        autocmd! * <buffer>
    --    augroup END
    --]], true)
end

lsp.pyright.setup{
    handlers = default_handlers,
    on_attach = on_attach,
}
