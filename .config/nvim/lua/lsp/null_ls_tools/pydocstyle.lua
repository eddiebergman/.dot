local util = require("util")
local _ = require("py")

local null_ls = require("null-ls")

local function parser(params)
    local query = "pydocstyle "..params.bufname

    -- pydocstyle prints over two lines, this magic cuts every second newline
    local newline_strip = 'paste -d " " - -'

    -- We then remove extraneuous whitespace
    local space_strip = 'tr -s " "'

    -- Remove trailing newline
    local cmd = _.join({query, "|", newline_strip, "|", space_strip})

    local raw, status = util.os_exec(cmd)

    if status > 1 then
        print("cmd "..cmd.." exit with status "..tostring(status))
        return {}
    end

    local lines = util.strsplit(raw, '\n')

    -- Pattern to match (line) and (message)
    local pattern = "^[^:]+:(%d+) [^:]+: (.*)$"

    -- Where diagnostics will be put
    local diagnostics = {}

    for line in lines do
        match = { line:match(pattern) }

        if not _.empty(match) then
            local line_diagnostics = {
                severity = 2,
                source = "pydocstyle",
                row = tonumber(match[1]),
                message = match[2],
            }
            table.insert(diagnostics, line_diagnostics)
        end

    end

    return diagnostics
end

local pydocstyle = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "python" },
    generator = { fn = parser },
}

return pydocstyle
