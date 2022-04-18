local ls = require("luasnip")

local self = {}
local filetypes = { "python" }

function self.setup()
    for _, ft in ipairs(filetypes) do
        local mod_name = "luasnips/"..ft
        local mod = require(mod_name)
        print(mod_name)
        print(vim.inspect(mod.snippets))
        ls.add_snippets(ft, mod.snippets)
    end
end

return self
