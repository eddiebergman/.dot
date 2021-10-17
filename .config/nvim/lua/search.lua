local self = {}
-- Mainly relies on nvim/telescope

local util = require('util')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

self.keymaps = {
    n = {
        -- [s]earch [s]tring (use ripgrep to find matches of string in workspace)
        {'<leader>ss', '<cmd>Telescope live_grep<CR>'},

        -- [s]earch [b]uffers
        {'<leader>sb', ':lua require("telescope.builtin").buffers()<CR>'},

        -- [s]earch [e]rrors
        {'<leader>se', ':lua require("telescope.builtin").lsp_document_diagnostics()<CR>'},

        -- [s]earch [r]eferences
        {'<leader>sr', ':lua require("search").references()<CR>'},

        -- [s]earch [o]bject
        {'<leader>so', ':lua require("telescope.builtin").treesitter({ show_line = false })<CR>'},

        -- search files (ctrl-P plugin habit) (search for a file in the workspace)
        {'<c-p>', ':lua require("search").files()<CR>'},

    }
}

function self.references()
    local opts = {
        layout_config = { width = 100 }
    }
    builtin.lsp_references(themes.get_cursor(opts))
end

function self.files()
    builtin.find_files({
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    })
end

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end
end

return self
