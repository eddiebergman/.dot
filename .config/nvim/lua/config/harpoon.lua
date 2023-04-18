local M = {}

function M.setup()
    require("harpoon").setup({
        global_settings = {
            enter_on_sendcmd = true,
        },
        projects = {
            ["$HOME/code/amltk/main"] = {
                term = {
                    cmds = {
                        "just test",
                        "just check",
                        "just check-types",
                        "just docs",
                        "just docs all",
                        "just test-examples"
                    }
                }
            }
        }
    })
end

return M
