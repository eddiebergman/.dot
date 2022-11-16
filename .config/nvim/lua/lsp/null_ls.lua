local self = {}

local null_ls = require("null-ls")
local methods = require("null-ls.methods")
local helpers = require("null-ls.helpers")
local util = require("util")
local git = require("git")

local function find_config(opts)
    -- Order in which to try find a config
    local default_configs = {
        "pyproject.toml",
        "setup.cfg",
        "tox.ini",
    }
    local files = opts.configs or default_configs
    local root = opts.root or git.repo_root()

    if root ~= nil then
        local paths = {}
        -- Append the root to each
        for _, config in ipairs(files) do
            table.insert(paths, util.joinpath(root, config))
        end

        -- If a config is found return it
        for _, path in ipairs(paths) do
            if util.file_exists(path) then
                return path
            end
        end
    end

    if opts.default ~= nil and util.file_exists(opts.default) then
        return opts.default
    end

    return nil
end

local function pydocstyle()
    -- Need to feed it a config file if we cant
    local pydoc = null_ls.builtins.diagnostics.pydocstyle
    local config = find_config({
        configs = { ".pydocstyle", ".pydocstyle.ini", ".pydocstylerc", ".pydocstylerc.ini" },
        default = util.joinpath(os.getenv("HOME"), ".config/pydocstyle/pyproject.toml")
    })

    if util.file_exists(config) then
        return pydoc.with(
            {
                args = { "$FILENAME", "--config=" .. config },
                method = null_ls.methods.DIAGNOSTICS
            })
    end

    return pydoc
end

local function pyupgrade(version)
    return helpers.make_builtin({
        name = "pyupgrade",
        meta = {
            url = "https://github.com/asottile/pyupgrade",
            description = "Automatically upgrade python syntax"
        },
        method = methods.internal.FORMATTING,
        filetypes = { "python" },
        generator_opts = {
            command = "pyupgrade",
            args = {
                "--" .. version .. "-plus"
            },
            to_stdin = true,
        },
        factory = helpers.formatter_factory
    })
end

local function pycln()
    local config = find_config({
        configs = { "pyproject.toml" }
    })

    local args = {"-s"}
    if config ~= nil then
        table.insert(args, "--config")
        table.insert(args, config)
    end

    table.insert(args, "-")

    print(vim.inspect(args))
    return helpers.make_builtin({
        name = "pycln",
        meta = {
            url = "https://github.com/hadialqattan/pycln",
            description = "Automatically remove unused imports"
        },
        method = methods.internal.FORMATTING,
        filetypes = { "python" },
        generator_opts = {
            command = "pycln",
            args = args,
            to_stdin = true
        },
        factory = helpers.formatter_factory
    })
end

function self.setup()
    null_ls.setup({
        sources = {
            pycln(),
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy.with({ method = null_ls.methods.DIAGNOSTICS }),
            null_ls.builtins.diagnostics.flake8.with({ method = null_ls.methods.DIAGNOSTICS }),
            null_ls.builtins.diagnostics.pylint.with({ method = null_ls.methods.DIAGNOSTICS }),
            pydocstyle(),
            pyupgrade("py37"),
            null_ls.builtins.code_actions.shellcheck
        },
        debug = false
    })
    -- local pyrate = require("pyrate")
    -- null_ls.register(pyrate.all())
end

return self
