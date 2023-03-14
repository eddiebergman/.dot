local self = {}
local cmp = require('cmp')
local luasnip = require('luasnip')

local function has_words_before()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- Source from: https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/cmp.lua
--
---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
    local win_get_cursor = vim.api.nvim_win_get_cursor
    local get_current_buf = vim.api.nvim_get_current_buf

    ---sets the current buffer's luasnip to the one nearest the cursor
    ---@return boolean true if a node is found, false otherwise
    local function seek_luasnip_cursor_node()
        -- TODO(kylo252): upstream this
        -- for outdated versions of luasnip
        if not luasnip.session.current_nodes then
            return false
        end

        local node = luasnip.session.current_nodes[get_current_buf()]
        if not node then
            return false
        end

        local snippet = node.parent.snippet
        local exit_node = snippet.insert_nodes[0]

        local pos = win_get_cursor(0)
        pos[1] = pos[1] - 1

        -- exit early if we're past the exit node
        if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        node = snippet.inner_first:jump_into(1, true)
        while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
                or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end

            if candidate then
                luasnip.session.current_nodes[get_current_buf()] = node
                return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        -- No candidate, but have an exit node
        if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
        end

        -- No exit node, exit from snippet
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil
        return false
    end

    if dir == -1 then
        ---@diagnostic disable-next-line: return-type-mismatch
        return luasnip.in_snippet() and luasnip.jumpable(-1)
    else
        ---@diagnostic disable-next-line: return-type-mismatch
        return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
    end
end

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

function self.setup()
    cmp.setup(
        {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end
            },

            enabled = function()
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                return buftype ~= "prompt"
            end,


            experimental = { ghost_text = false },

            duplicates = {
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            },

            duplicates_default = 0,

            mapping = {
                ['<A-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ['<A-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ['<C-e>'] = cmp.mapping.close(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif jumpable(1) then
                        luasnip.jump(1)
                    elseif has_words_before() then
                        -- cmp.complete()
                        fallback()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            completion = { keyword_length = 1, },

            formatting = {
                fields = { "abbr", "kind" },
                format = function(_, vim_item)
                    local icon = kind_icons[vim_item.kind]
                    vim_item.kind = string.format("%s %s", icon, vim_item.kind)
                    vim_item.dup = 0  -- Disable duplicate entries
                    return vim_item
                end,
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = "luasnip" },
                }
            ),
        }
    )

    cmp.setup.cmdline({ '/', '?' }, {
        sources = { { name = 'buffer' } }
    })

    cmp.setup.cmdline(':', {
        view = { entries = "custom" },
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
    })

end

return self
