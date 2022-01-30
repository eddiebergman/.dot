local self = {}
local cmp = require('cmp')
local neogen = require("neogen")
local autopairs = require("nvim-autopairs")
local autopairs_cmp = require("nvim-autopairs.completion.cmp")
local ppbr = require('colorschemes/ppbr')

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
                if neogen.jumpable() then
                    vim.fn.feedkeys(t("<cmd>lua require('neogen').jump_next()<CR>"), "")
                elseif cmp.visible() then
                    cmp.select_next_item({behaviour = cmp.SelectBehaviour })
                else
                    fallback()
                end
            end
        ),
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if neogen.jumpable(-1) then
                    vim.fn.feedkeys(t("<cmd>lua require('neogen').jump_prev()<CR>"), "")
                elseif cmp.visible() then
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
    }
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

    self.capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    --autopairs.setup({})
    --cmp.event:on("confirm_done",
    --    autopairs_cmp.on_confirm_done({ map_char = { tex = '' } })
    --)

    return
end

return self
