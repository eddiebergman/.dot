local self = {}
local cmp = require('cmp')
local ppbr = require('colorschemes/ppbr')


local cmp_config = {
    -- snippet = {
    --  expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    --  end,
    -- },
    mapping = {
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-l>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<C-space>'] = cmp.mapping.confirm({ select = true }),
    },
    documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBoarder',
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        },
        {
            { name = 'buffer' },
        }
    )
}

function self.setup()

    local winhighlights = {}
    for k, _ in pairs(ppbr.base_highlights) do
        table.insert(winhighlights, k..':'..k)
    end
    local winhighlight_str = table.concat(winhighlights, ',')

    local function arg(k)
        return k..':'..k
    end

    cmp_config.documentation.winhighlight = "Normal:Normal"
    cmp.setup(cmp_config)

    -- Also includes extending capabilities in lsp.lua
    return
end

return self
