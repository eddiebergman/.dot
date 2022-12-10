local M = {}
local builtins = require("null-ls.builtins")
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting
local util = require("util")

function M.find_local(language)
    if language == "python" then
        -- Will attempt to find your python env using VirtualEnv, Conda or virtual env patterns
        local python_env = util.python_env({ patterns = { "venv", ".venv", "env", ".env" } })
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
        debug = true, -- :NullLsLog to get the log if deubg is on
        sources = {
            diagnostics.ruff.with({ prefer_local = python }), -- python linter
            diagnostics.mypy.with({ prefer_local = python }), -- python type checking
            formatting.black.with({ prefer_local = python }), -- python formatter
            diagnostics.flake8.with({ -- Flake8 only if `.flake8` found
                prefer_local = python,
                condition = function(u) return u.root_has_file({ ".flake8" }) end,
            }),
            --diagnostics.pylint.with({ prefer_local = local_binary_dir}), -- Disabled, enable if you like
            --formatting.isort.with({ prefer_local = local_binary_dir}), -- Disabled, enable if you like
            --diagnostics.commitlint, -- If using commitizen
            diagnostics.actionlint, -- github action linter
            diagnostics.yamllint, -- yaml linter
            formatting.yamlfmt, -- yaml formatter
            formatting.clang_format, -- c/c++ formatter
            formatting.jq, -- json formatter
            formatting.shfmt, -- shell formatter
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
