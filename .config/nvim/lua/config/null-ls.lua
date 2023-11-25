local M = {}
local builtins = require("null-ls.builtins")
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")
local util = require("util")

function M.check_for(paths)
    return function(_)
        for path, pattern in pairs(paths) do
            if util.file_contains(path, pattern) then
                return true
            end
        end
        return false
    end
end

function M.find_local(language)
    if language == "python" then
        -- Will attempt to find your python env using VirtualEnv, Conda or virtual env patterns
        local python_env = util.python_env({ patterns = { "venv", ".venv", "env", ".env", ".eddie-venv" } })
        if not python_env then
            return nil
        end

        local rootdir = util.lsp_root({
            ".git", "setup.py", "requirements.txt", "poetry.lock", "Pipfile", "Pipfile.lock",
            "pyproject.toml", "setup.cfg", "tox.ini", "mypy.ini", "pylintrc",
        })
        return python_env.bindir:gsub(rootdir, "")
    end
end

function M.setup()
    local python = M.find_local("python")

    require("null-ls").setup({
        debug = false, -- :NullLsLog to get the log if deubg is on
        sources = {
            diagnostics.mypy.with({
                prefer_local = python,
                condition = function () M.check_for({ ["mypy.ini"] = ".*", ["pyproject.toml"] = "tool.mypy" }) end
            }),
            formatting.black.with({
                prefer_local = python,
                condition = M.check_for({ ["pyproject.toml"] = "tool.black" })
            }),
            diagnostics.flake8.with({
                prefer_local = python,
                condition = M.check_for({ [".flake8"] = ".*" })
            }),
            -- diagnostics.pylint.with({
              --   prefer_local = python,
                -- condition = M.check_for({ [".pylintrc"] = ".*", ["pyproject.toml"] = "tool.pylint" })
            -- }),
            formatting.isort.with({
                prefer_local = python,
                condition = M.check_for({ ["isort.cfg"] = ".*", ["pyproject.toml"] = "tool.isort" })
            }),
            -- diagnostics.commitlint,
            diagnostics.actionlint,
            formatting.yamlfmt,
            formatting.clang_format,
            formatting.jq,
            formatting.shfmt,
        },
        temp_dir = "/tmp",
        diagnostics_format = "[#{c}] #{m} (#{s})" -- [code] message (source)
    })

    -- This needs to run last
    -- It will try to autmatically install what it has access to
    require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = true
    })

end

return M
