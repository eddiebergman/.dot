local M = {}
local signs = require("signs")
local severity = vim.diagnostic.severity


local function get_diagnostic_count(sev)
    return #vim.diagnostic.get(0, { severity = sev })
end

function M.get_diagnostic_text()
    local severities = {
        DiagnosticSignError = severity.ERROR,
        DiagnosticSignWarn = severity.WARN,
        DiagnosticSignInfo = severity.INFO,
        DiagnosticSignHint = severity.HINT
    }

    local items = {}
    for name, sev in pairs(severities) do
        local count = get_diagnostic_count(sev)
        if count > 0 then
            items[name] = { sign = signs.get_sign(name), count = count }
        end
    end

    local text = {}
    for name, info in pairs(items) do
        table.insert(text, "%#" .. name .. "#" .. info.sign .. " " .. info.count)
    end
    return table.concat(text, " ")
end

function M.setup()
    require("nvim-navic").setup({ highlight = true })
    local winbar_parts = {
        "%#@constant#%t", -- filename
        " > ", -- just a seperator
        "%{%v:lua.require'nvim-navic'.get_location()%}", -- breadcrumbs
        "%=", -- Seperate
        "%{%v:lua.require('config/nvim-navic').get_diagnostic_text()%}", -- Diagnostics
    }

    vim.o.winbar = table.concat(winbar_parts, "")
    vim.api.nvim_set_hl(0, "NavicText", { link = "@string.regex" })
end

return M
