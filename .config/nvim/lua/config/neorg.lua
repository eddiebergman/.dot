local self = {}
local util = require("util")

local neorg = require("neorg")

local concealer_icons = { { heading = { enabled = false, } }, diff = "" }

function self.setup()
    neorg.setup({
        load = {
            ["core.defaults"] = {},
            ["core.norg.esupports.metagen"] = {
                config = {
                    type = "auto"
                }
            },
            ["core.keybinds"] = {
                config = {
                    neorg_leader = ",",
                    hook = function(keybinds)
                        keybinds.map("norg", "n", "<C-k>", "core.norg.manoeuvre.item_up")
                        keybinds.map("norg", "n", "<C-j>", "core.norg.manoeuvre.item_down")
                        keybinds.map("norg", "n", "<C-h>", "<cmd>Neorg toc split<CR>")
                        keybinds.remap(
                            "norg",
                            "n",
                            "gtd",
                            'k:r!echo "\\#time.done $(date -Idate)"<cr>j:execute "Neorg keybind norg core.norg.qol.todo_items.todo.task_done"<cr>')
                    end,
                },
            },
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/org/notes",
                        journal = "~/org/journal",
                        gtd = "~/org/gtd",
                    },
                },
            },
            ["core.norg.manoeuvre"] = {},
            ["core.norg.completion"] = { config = { engine = "nvim-cmp", } },
            ["core.norg.concealer"] = {
                config = { icons = concealer_icons }
            },
            -- ["core.integrations.telescope"] = {},
            ["core.export"] = {
                config = {
                    export_dir = "~/notes/export",
                },
            },
            ["core.presenter"] = { config = {
                zen_mode = "zen-mode",
            } },
            ["core.export.markdown"] = {},
            ["core.norg.qol.toc"] = {
                config = { keep_buf = true },
            },
            ["core.norg.journal"] = {
                config = {
                    workspace = "journal",
                },
            },
            ["core.gtd.base"] = {
                config = {
                    workspace = "gtd",
                },
            },
        },
    })

    -- Start Neorg
    -- vim.cmd(":NeorgStart silent=true")

    util.setkey("n", "<leader>tc", "<cmd>Neorg gtd capture<cr>")
    util.setkey("n", "<leader>tv", "<cmd>Neorg gtd views<cr>")

    -- Calendar
    vim.cmd("source ~/.cache/calendar.vim/credentials.vim")
    vim.g.calendar_views = { "week", "month", "year" }
    vim.g.calendar_view = "week"
    vim.g.calendar_cyclic_view = true
    vim.g.calendar_google_calendar = true
    vim.g.calendar_google_task = true
    vim.g.calendar_date_endian = "big"
    vim.g.calendar_position = "right"
    vim.g.calendar_date_separator = "."
    vim.g.calendar_frame = "unicode_round"
    vim.g.calendar_calendar_candidates = { "Eddie's Work Calendar", "eddiebergmanhs@gmail.com" }

    util.setkey("<leader>cc", "<cmd>Calendar -position=right<cr>")

end

return self
