local self = {}
local items = require('py').items

self.colorschemes = {
--  name = {background, base_theme}
    --ppbr = {"dark", "stellarized"}
    ppbr = function () return require("colorschemes/ppbr") end,
    forest = function () return require("colorschemes/forest") end,
    gruvbox = function () return require("colorschemes/gruvbox") end,
    paper = function () return require("colorschemes/paper") end,
    tokyonight = function () return require("colorschemes/tokyonight") end
}
self.default = "tokyonight"

function self.setup()
    self.set(self.default)
end

function self.set(name)
    local scheme = self.colorschemes[name]()

    if scheme.setup ~= nil then
        scheme.setup()
    end
    
    vim.cmd("colo "..name)

    if scheme.highlights ~= nil then
        for group, args in items(scheme.highlights) do
            local strbuf = { "hi "..group }
            for k, v in pairs(args) do
                table.insert(strbuf, k..'='..v) end

            vim.cmd('hi clear '..group)
            vim.cmd(table.concat(strbuf, ' '))
        end
    end
end


return self
