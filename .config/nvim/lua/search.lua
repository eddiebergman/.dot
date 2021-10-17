local self = {}
-- Mainly relies on nvim/telescope

local util = require('util')
local builtin = require('telescope.builtin')

self.keymaps = {
    n = {
        -- [s]earch [s]tring (use ripgrep to find matches of string in workspace)
        {'<leader>ss', '<cmd>Telescope live_grep<CR>'},

        -- search files (ctrl-P plugin habit) (search for a file in the workspace)
        {'<c-p>', ':lua require("search").files()<CR>'},
    }
}

function self.files()
    builtin.find_files({
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    })
end

function self.search_string()
    return
end

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end
end

return self
