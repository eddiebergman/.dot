local setkey = require("util").setkey
local command = require("util").command

setkey({ key = "<C-t>", cmd = "maA  # type: ignore<esc>`a" })
setkey({
    key = "<leader>i",
    cmd = "?^\\(from\\|import\\)<CR>:nohl<CR>o<C-d>",
    ft = "python",
})
command({
    key = "<leader>p",
    name = "RunPython",
    ft = "python",
    cmd = function()
        -- Get the current filename
        local filename = vim.fn.expand("%")

        -- Open up a vsplit with the terminal
        vim.cmd.vsplit()
        vim.cmd.terminal()

        -- Set it so that when it's hidden it is closed
        vim.cmd("setlocal bufhidden=delete")

        -- send the command to the terminal buffer
        vim.api.nvim_chan_send(vim.bo.channel, "python " .. filename .. "\n")
    end,
})
