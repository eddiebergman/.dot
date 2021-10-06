
local self = {}

function self.setup()
    vim.cmd([[
    augroup FileTypes
        autocmd!
        autocmd WinEnter,BufEnter *.cff set ft=yaml
    augroup END
    ]])
end

return self
