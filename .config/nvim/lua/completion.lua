local self = {}
local cmp = require('cmp')
local luasnip = require("luasnip")

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local source_names = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snippet]",
    buffer = "[Buffer]",
    path = "[Path]",
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp_config = {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end
        ),
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end
        ),
        ['<C-y>'] = cmp.config.disable,
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    },
    documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    experimental = {
        ghost_text = false,
    },
    formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
            local icon = kind_icons[vim_item.kind]
            vim_item.kind = string.format("%s %s", icon, vim_item.kind)
            --vim_item.menu = source_names[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' }
    },
    sorting = {
        comparators = {
          require("cmp-under-comparator").under,
        }
    }
}

function self.setup()

    cmp.setup(cmp_config)

    self.capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    return
end

return self
