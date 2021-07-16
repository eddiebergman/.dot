-- TODO: Get code formatting for Python to work
local lsp = require('lspconfig')
local util = require('util')
local get = util.get
local setkey = vim.api.nvim_buf_set_keymap

-- ==============
-- Config options
-- ==============
-- Where the sumneko/lua-language-server is located
local sumneko_root_path = os.getenv("HOME").."/software/lua-language-server"

-- Whether to show the virtual text beside the lines
local show_virtual_text = false

-- =======
-- Keymaps
-- =======
-- Get's called upon set in buffer upon loading an lsp local 
normal_keymaps = {
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
            virtual_text = show_virtual_text
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

-- Python
if util.executable("pyright") then
    lsp.pyright.setup {
        handlers = default_handlers,
        on_attach = on_attach,
    }
else
    print([[
        `pyright` language server could not be found.
        $ npm install -g pyright

        For custom NPM_PACKAGES location

        --.zshrc
        export NPM_PACKAGES="..."
        export PATH="${PATH}:{NPM_PACKAGES}/bin"

        --.npmrc
        prefix = ${NPM_PACKAGES}
    ]])
end

-- Lua
local system_name = util.system_name()
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

if util.executable(sumneko_binary) == 1 then
    lsp.sumneko_lua.setup {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    }
                },
                telemetry = { enable = false }
            }
        },
        on_attach = on_attach,
        handlers = default_handlers
    }
else
    print(string.format([[
        lua-language-server not found, looking for root at:

            local sumneko_root_path = %s

        https://github.com/sumneko/lua-language-server
        ]], sumneko_root_path))
end

return {
    on_attach = on_attach
}
