local self = {}
local cmp = require('cmp')
local neogen = require("neogen")
local autopairs = require("nvim-autopairs")
local autopairs_cmp = require("nvim-autopairs.completion.cmp")
local ppbr = require('colorschemes/ppbr')
local cmp_buffer = require("cmp_buffer")

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
            require('snippy').expand_snippet(args.body)
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({behaviour = cmp.SelectBehaviour })
                else
                    fallback()
                end
            end
        ),
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({behaviour = cmp.SelectBehaviour })
                else
                    fallback()
                end
            end
        ),
        ['<C-y>'] = cmp.config.disable,
        ['<C-Space>'] = cmp.mapping.confirm({ select = true, behaviour = cmp.ConfirmBehavior }),
    },
    documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    experimental = {
        native_menu = false,
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
        { name = 'nvim_lsp' },
        { name = 'snippy' }, -- For ultisnips users.
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
