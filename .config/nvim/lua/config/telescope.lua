-- https://github.com/nvim-telescope/telescope.nvim
local M = {}
local telescope = require("telescope")
local actions = require("telescope.actions")

function M.layout_1(opts)
    local layout_1 = {
        previewer = true,
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        border = true,
        borderchars = {
            "z",
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            -- results = { "a", "b", "c", "d", "e", "f", "g", "h" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        layout_config = {
            height = 25,
            prompt_position = "top"
        },
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            tail = tail .. string.rep(" ", 30 - #tail)
            return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
        end,
    }
    opts = opts or {}
    return vim.tbl_deep_extend("force", layout_1, opts)
end

local custom_actions = {}

custom_actions.scroll_top = function (prompt_bufnr)
    vim.cmd(":normal! zt")
end
local transform_mod = require("telescope.actions.mt").transform_mod
custom_actions = transform_mod(custom_actions)

-- Any extra configueration of Telescope you may want
-- :help Telescope.setup
function M.setup()
    telescope.setup({
        extensions = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = false,
            case_mode = "smart_case",
        },
        preview = true,
        defaults = {
            file_ignore_patterns = { ".git/", ".venv*/", "*.svg", "*.png", "*.pdf" },
            mappings = {
                i = {
                    ["<CR>"] = actions.select_default + custom_actions.scroll_top,
                    ["<esc>"] = actions.close,
                    ["<A-j>"] = actions.move_selection_next,
                    ["<A-k>"] = actions.move_selection_previous,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                },
                n = {
                    ["q"] = actions.close,
                    ["<A-j>"] = actions.move_selection_next,
                    ["<A-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.cycle_history_next,
                    ["<c-k>"] = actions.cycle_history_prev,
                    ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                }
            }
        },
        pickers = {
            buffers = M.layout_1(),
            find_files = M.layout_1(),
            lsp_document_symbols = M.layout_1({ ignore_symbols = { "variable" } }),
            lsp_references = M.layout_1(),
            help_tags = M.layout_1(),
            commands = M.layout_1(),
            highlights = M.layout_1(),
            builtin = M.layout_1({previewer = false}),
            git_bcommits = M.layout_1(),
            git_branches = M.layout_1(),
            git_commits = M.layout_1(),
            live_grep = M.layout_1({
                path_display = function(opts, path)
                    local tail = require("telescope.utils").path_tail(path)
                    tail = tail .. string.rep(" ", 25 - #tail)
                    return string.format("%s", tail), { { { 1, #tail }, "Constant" } }
                end,
            }),
            -- commands = center_list,
            -- marks = center_list,
        }
    })
    require("telescope").load_extension("fzf")
end

return M
