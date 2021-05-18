local M = {}
local util = require('util')
local foreach = util.foreach
local has = vim.fn['has']

-- ===========
-- Colors opts
-- ===========
-- Colorscheme
vim.cmd [[ colo stellarized ]] -- Base Color scheme
vim.o.background = 'dark'
local colorscheme = require('colorschemes/ppbr')

-- ============
-- Checks
-- ============
if has("termguicolors") then vim.o.termguicolors = true end


-- ====================
-- Apply the highlights
-- ====================
-- These are applied on buffer load to enable overwriting of any colorscheme
-- settings.
local function cmd_highlight(group, args)
    local strbuf = { "hi "..group }
    for k, v in pairs(args) do
        table.insert(strbuf, k..'='..v)
    end
    vim.cmd('hi clear '..group)
    vim.cmd(table.concat(strbuf, ' '))
end

function M.apply_highlights()
    foreach(colorscheme, cmd_highlight)
end

vim.cmd [[
augroup Highlight
    au!
    au ColorScheme * lua require('colors').apply_highlights()
augroup End
]]

return M
