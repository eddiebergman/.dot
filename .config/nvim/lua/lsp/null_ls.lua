local self = {}

local null_ls = require("null-ls")
local util = require("util")

local function pydocstyle()
    -- Need to feed it a config file if we cant
    local pydoc = null_ls.builtins.diagnostics.pydocstyle

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

    local paths = {}
    -- Append the root to each
    for _, config in ipairs(order) do
        table.insert(paths, util.joinpath(root, config))
    end

    -- Add a global config
    local expected_root_config = util.joinpath(os.getenv("HOME"), ".config/pydocstyle/pyproject.toml")
    table.insert(paths, expected_root_config)

    -- If a config is found return it
    for _, path in ipairs(paths) do
        if util.file_exists(path) then
            return pydoc.with({ args = { "$FILENAME", "--config=" .. path } })
        end
    end

    -- Couldnt find any
    return pydoc

end

function self.setup()
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black.with({ filetypes = { "python" } }),
            null_ls.builtins.formatting.isort.with({ filetypes = { "python" } }),
            null_ls.builtins.diagnostics.mypy.with({ filetypes = { "python" } }),
            null_ls.builtins.diagnostics.flake8.with({ filetypes = { "python" } }),
            pydocstyle().with({ filetypes = { "python" } }),
            null_ls.builtins.code_actions.shellcheck.with({ filetypes = { "sh" } }),
        }
    })
end

return self
