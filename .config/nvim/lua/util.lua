local M = {}

function M.setkey(opts)
    vim.validate({
        key = { opts.key, "string" },
        cmd = { opts.cmd, { "string", "function" } },
        mode = { opts.mode, { "string" }, true },
        opts = { opts.opts, { "table" }, true },
    })
    local key = opts.key
    local cmd = opts.cmd
    local mode = opts.mode or "n"
    local extra = opts.opts or { noremap = true, silent=true }
    vim.api.nvim_set_keymap(mode, key, cmd, extra)
end

-- { name: str, cmd: str | func, key: str | {mode, key} }
function M.command(opts)
    vim.validate({
        name = { opts.name, "string" },
        cmd = { opts.cmd, { "string", "function" } },
        key = { opts.key, { "string", "table" }, true },
    })
    local cmd_opts = opts.opts or {}

    if opts.name:match("%W") and not opts.name:match("^%l") then
        error("Command name must be alphanumeric and start with Captial letter\n" .. vim.inspect(opts))
        return
    end

    vim.api.nvim_create_user_command(opts.name, opts.cmd, cmd_opts)

    if opts.key ~= nil then
        local action = "<cmd>" .. opts.name .. "<cr>"

        local mode = "n"
        local key = opts.key

        -- If key is a table then it includes the mode
        if type(key) == "table" then
            mode = key[1]
            key = key[2]
        end

        M.setkey({ mode = mode, key = key, cmd = action })
    end
end


function M.python_env(opts)
    -- This will use the following strategies, in order to determine the python env
    -- 1. VIRTUAL_ENV
    -- 2. CONDA_DEFAULT_ENV
    -- 3. If opts.patterns are provided for virtual env names are passed, then search for those
    --      This will use the `vim.fn.getcwd()` or override with `opts.root`.
    --      If several matches are found for a pattern, it will take the first, giving priority
    --      to the first patterns in the list.
    -- If none of these are found, this will fail and return nil

    vim.cmd("PackerLoad nvim-lspconfig")
    local util = require("lspconfig/util")
    local path = util.path
    local join = path.join

    local bindir = nil

    -- 1. Use virtualenv if present
    if vim.env.VIRTUAL_ENV then
        bindir = join(vim.env.VIRTUAL_ENV, "bin")
        return { python = join(bindir, "python"), bindir = bindir }
    end

    -- 2. Use conda env if present
    if vim.env.CONDA_DEFAULT_ENV then
        bindir = join(vim.env.CONDA_DEFAULT_ENV, "bin")
        return { python = join(bindir, "python"), bindir = bindir }
    end


    -- 3. Search for patterns from root or workspace
    if opts.patterns then
        -- Find and use virtualenv in workspace directory.
        local root = opts.root or vim.fn.getcwd()
        for _, pattern in ipairs(opts.patterns) do
            local matches = vim.fn.glob(join(root, pattern), true, true)
            local _, env = next(matches)
            if env and path.exists(join(env, "python")) then
                bindir = join(env, "bin")
            end
        end
        if bindir then
            return { python = join(bindir, "python"), bindir = bindir }
        end
    end

    -- 4. No python env found, try to use system python
    local pythonpath = vim.fn.exepath("python3") or vim.fn.exepath("python") or nil
    if pythonpath then
        return { python = pythonpath, bindir = path.dirname(pythonpath) }
    end

    return nil
end

function M.lsp_root(patterns)
    local cwd = vim.fn.getcwd()
    return require("lspconfig").util.root_pattern(unpack(patterns))(cwd)
end


function M.file_contains(file, pattern)
    local f = io.open(file, "r")
    if f == nil then
        return false
    end
    local content = f:read("*all")
    f:close()
    return content:match(pattern) ~= nil
end

return M
