local M = {}

function M.setup()
    require("trouble").setup({
        position = "right",
        action_keys = { toggle_fold = {"zA", "za", "<space>"} },
        use_diagnostic_signs = true
    })
end

return M
