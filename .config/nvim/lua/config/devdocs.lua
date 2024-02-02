local M = {}


function M.setup()
    local layout = require("config/telescope").layout_1
    local actions = require("telescope.actions")
    require("nvim-devdocs").setup(
        {
            ensure_installed = {
                "python-3.12",
                "matplotlib-3.7",
                "pandas-1",
                "numpy-1.23",
                "pytorch-2",
                "scikit_learn",
            },
            telescope = layout({
                mappings = {
                    i = {
                        ["<CR>"] = actions.select_horizontal,
                        ["<esc>"] = actions.close,
                        ["<A-j>"] = actions.move_selection_next,
                        ["<A-k>"] = actions.move_selection_previous,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<A-j>"] = actions.move_selection_next,
                        ["<A-k>"] = actions.move_selection_previous,
                        ["<c-j>"] = actions.cycle_history_next,
                        ["<c-k>"] = actions.cycle_history_prev,
                    }
                }
            })
        }
    )
end

return M
