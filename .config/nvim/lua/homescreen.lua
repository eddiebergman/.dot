local M = {}
local workspace = require("workspace")

local WORKSPACE_PAD = 6

local header = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = {
        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    },
    highlight = "Statement",
    default_color = "#FF0000",
    oldfiles_amount = 0,
}

function M.section_workspaces()
    local body = {
        type = "mapping",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Workspaces",
        margin = 5,
        highlight = "String",
        default_color = "#FF0000",
        oldfiles_amount = 0,
    }


    -- Get the maximum name length
    local l_longest = 0
    for _, ws in ipairs(workspace.workspaces()) do
        local name_length = string.len(ws.name)
        if name_length > l_longest then
            l_longest = name_length
        end
    end

    -- Create the strings and mappings
    local l_end = l_longest + WORKSPACE_PAD

    local workspaces = {}
    for i, ws in ipairs(workspace.workspaces()) do
        local reps = l_end - string.len(ws.name)
        local s = ws.name .. "  " .. string.rep(" ", reps) .. "  " .. ws.path
        table.insert(workspaces, { s, "WorkspacesOpen " .. ws.name, tostring(i) })
    end

    body["content"] = workspaces
    return body
end

function M.setup(skip)
    if skip == false then
        return
    end

    require("startup").setup({
        header = header,
        workspaces = M.section_workspaces(),
        options = {
            mapping_keys = true, -- display mapping (e.g. <leader>ff)
            cursor_column = 0.5,
            after = function() -- function that gets executed at the end
            end,
            empty_lines_between_mappings = true, -- add an empty line between mapping/commands
            disable_statuslines = true, -- disable status-, buffer- and tablines
            paddings = { 20, 5 }, -- amount of empty lines before each section (must be equal to amount of sections)
        },
        mappings = {
            execute_command = "<CR>",
            open_file = "o",
            open_file_split = "<c-o>",
            open_section = "<TAB>",
            open_help = "?",
        },
        colors = {
            background = "#1f2227",
            folded_section = "#56b6c2", -- the color of folded sections
            -- this can also be changed with the `StartupFoldedSection` highlight group
        },
        parts = { "header", "workspaces" }
    })


end

return M
