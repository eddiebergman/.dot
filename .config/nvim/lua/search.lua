local self = {}
-- Mainly relies on nvim/telescope

local util = require('util')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

self.keymaps = {
    n = {
        -- [s]earch [s]tring (use ripgrep to find matches of string in workspace)
        {'<leader>ss', ':lua require("search").live_grep()<CR>'},

        -- [s]earch [b]uffers
        {'<leader>sb', ':lua require("telescope.builtin").buffers()<CR>'},

        -- [s]earch [e]rrors
        {'<leader>se', ':Telescope diagnostics bufnr=0<CR>'},

        -- [s]earch [r]eferences
        {'<leader>sr', ':lua require("search").references()<CR>'},

        -- [s]earch [o]bject
        {'<leader>so', ':lua require("telescope.builtin").treesitter({ show_line = false })<CR>'},

        -- search files (ctrl-P plugin habit) (search for a file in the workspace)
        {'<c-p>', ':lua require("search").files()<CR>'},

    }
}

function self.live_grep()
    if util.orientation() == 'vertical' then
        builtin.live_grep(themes.get_dropdown())
    else
        builtin.live_grep()
    end
end

function self.references()
    local opts = {
        layout_config = { width = 100 }
    }
    builtin.lsp_references(themes.get_cursor(opts))
end

function self.files()
    local ignores = {'!.git', '!.venv', '!.mypy_cache'}
    local find_command = { 'rg', '--files', '--hidden' }

    for _, item in ipairs(ignores) do
        table.insert(find_command, '-g')
        table.insert(find_command, item)
    end

    if util.orientation() == "vertical" then
        opts = {
            find_command = find_command,
            layout_strategy = "vertical",
            layout_config = {
                width = 0.8,
                height = { padding = 0.2 },
                prompt_position="top"
            },
            sorting_strategy="ascending",
        }
    else
        opts = {
            find_command = find_command,
            layout_strategy = "horizontal",
            layout_config = {
                width = 0.8,
                height = 0.6,
            }
        }
    end
    builtin.find_files(opts)
end

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end
end

return self
