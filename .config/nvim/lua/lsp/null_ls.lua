local self = {}

local null_ls = require("null-ls")
local util = require("util")

local function pydocstyle()
    -- Need to feed it a config file if we cant
    pydoc = null_ls.builtins.diagnostics.pydocstyle

    -- We use git as a proxy for the root dir, otherwise setup.py
    local git = require("git")
    local root = git.repo_root()
    if root == nil then
        return pydoc
    end

    -- Order in which to try find a config
    local order = {
        "pyproject.toml",
        "setup.cfg",
        "tox.ini",
        ".pydocstyle",
        ".pydocstyle.ini",
        ".pydocstylerc",
        ".pydocstylerc.ini",
    }

    -- If a config is found return it
    for _, config in ipairs(order) do
        path = util.joinpath(root, config)
        if util.file_exists(path) then
            return pydoc.with({args = { "$FILENAME", "--config="..path}})
            --return pydoc
        end
    end

    -- Couldnt find any
    return pydoc

end

function self.setup()
    null_ls.setup({
        debug = true,
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.diagnostics.flake8,
            pydocstyle(),
        }
    })
end

return self
