-- https://github.com/nvim-telescope/telescope.nvim
local M = {}
local telescope = require("telescope")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

-- Dropdown list theme using a builtin theme definitions :
local center_list = themes.get_dropdown({
    width = 0.5,
    prompt = " ",
    previewer = false,
})

-- Any extra configueration of Telescope you may want
-- :help Telescope.setup
function M.setup()
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<c-l>"] = trouble.open_with_trouble,
                    ["<c-j>"] = actions.cycle_history_next,
                    ["<c-k>"] = actions.cycle_history_prev,
                },
                n = {
                    ["q"] = actions.close,
                    ["<c-l>"] = trouble.open_with_trouble,
                    ["<A-j>"] = actions.preview_scrolling_down,
                    ["<A-k>"] = actions.preview_scrolling_up,
                    ["<c-j>"] = actions.cycle_history_next,
                    ["<c-k>"] = actions.cycle_history_prev,
                }
            }
        },
        pickers = {
            buffers = center_list,
            find_files = center_list,
            commands = center_list,
            -- marks = center_list,
        }
    })
    require("telescope").load_extension("fzf")
end

return M
