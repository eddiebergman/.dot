local M = {}

-- https://github.com/nvim-tree/nvim-tree.lua
-- This plugin is for the tree-view which I have mapped to <C-h> since it bumps
-- out from the left
-- Try it out
--
--  <C-h> - Expand tree
--  j / k to move up and down
--  l to expand node or open if file
--  h to collapse section
--  L to open but stay in tree
--  H to collapse all

-- 
-- `a` - add a file or directory
--      add a file somewhere 
--      add a directory somewhere by ending it in a slash `/`
--  https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#h-j-k-l-style-navigation-and-editing

-- `d` - delete a file/directory
--      delete the file you create or 

-- Type `/config` to see how these kind of plugins are configured normally
-- and then come back here (<ctrl-o>)

-- The other two forms of navigation are bound to `<Ctrl+e>` and `<Ctrl+p>`
-- The first runs `:Telescope buffers` and the second `:Telescope find_files`
-- Use whichever one you like to get back to `init.lua`


local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")


local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    if node  == nil then
        return
    end

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    if node  == nil then
        return
    end

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local config = {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    renderer = {
        highlight_opened_files = "name",
        icons = {
            show = {
                git = false,
                folder = true,
                folder_arrow = false,
                file = true,
            },
            glyphs = {
                folder = {
                    default = "",
                    open = "",
                }
            }
        }
    },
    view = {
        width = 30,
        hide_root_folder = true,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                { key = "l", action = "edit", action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                { key = "h", action = "close_node" },
                { key = "H", action = "collapse_all" },
                { key = "t", action = "toggle_git_ignored" }
            }
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    trash = {
        cmd = "trash",
        require_confirm = true
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = { enable = false, }
        }
    }
}


function M.setup()
    require('nvim-tree').setup(config)
    -- This just nvim quit properly if the tree is the last window open
    vim.cmd([[
        autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    ]])

end

return M

