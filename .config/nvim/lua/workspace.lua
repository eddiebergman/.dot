local M = {}
local commands = require("commands")
local python = require("python")
local workspaces = require("workspaces")


function M.workspaces()
    local items = {}
    for _, entry in ipairs(workspaces.get()) do
        table.insert(items, { name = entry.name, path = entry.path })
    end
    return items
end

function M.switch(name)
    vim.cmd("WorkspacesOpen "..name)
end

function M.add(name)
    vim.cmd("WorkspacesAdd"..name)
end

function M.setup()
    require("workspaces").setup({
        hooks = {
            open = {
                "NvimTreeOpen",
                function()
                    if python.exists() then
                        python.activate()
                    end
                end,
            },
            open_pre = function()
                if python.active() then
                    python.deactivate()
                end
            end
        }
    })

    commands.register({
        name = "FindWorkspace",
        key = "<leader>ww",
        cmd = "Telescope workspaces"
    })
end

return M
