local ls = require("luasnip")

local self = {}
local filetypes = { "python" }

function self.setup()
    for _, ft in ipairs(filetypes) do
        ls.add_snippets(ft, require("luasnips/"..ft).snippets)
    end
end

return self
