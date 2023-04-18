local M = {}

function M.setup()
    require("overseer").setup({
        task_list = {
            bindings = {
                ["r"] = "<CMD>OverseerQuickAction restart<CR>",
                ["d"] = "<CMD>OverseerQuickAction dispose<CR>",
                ["L"] = "<CMD>OverseerQuickAction open vsplit<CR>",
                ["s"] = "<CMD>OverseerQuickAction stop<CR>",
                ["q"] = "<CMD>OverseerQuickAction open output in quickfix<CR>",
            }
        }
    })
end

return M
