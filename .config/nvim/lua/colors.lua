local M = {}
local items= require('py').items

-- ===========
-- Colors opts
-- ===========
-- Colorscheme
vim.o.background = 'dark'
local colorscheme = require('colorschemes/ppbr')

-- ============
-- Checks
-- ============
if vim.fn.has("termguicolors") then vim.o.termguicolors = true end


-- ====================
-- Apply the highlights
-- ====================
-- These are applied on buffer load to enable overwriting of any colorscheme
-- settings.
local function cmd_highlight(group, args)
    local strbuf = { "hi "..group }
    for k, v in pairs(args) do
        table.insert(strbuf, k..'='..v) end

    vim.cmd('hi clear '..group)
    vim.cmd(table.concat(strbuf, ' '))
end

function M.apply_highlights()
    for group, args in items(colorscheme) do
        cmd_highlight(group, args) end
end

vim.cmd [[
augroup Highlight
    au!
    au ColorScheme * lua require('colors').apply_highlights()
augroup End
]]

function M.setup()
    vim.cmd("colo stellarized") -- Base Color scheme
    M.apply_highlights()
end


return M
