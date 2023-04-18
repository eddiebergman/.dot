local M = {}

function M.add(opts)
    vim.validate ({
        name = { opts.name, "string" },
        bufnr = { opts.bufnr, "number", true },
        hl = { opts.hl, "string", true },
        lines = { opts.lines, "table"},
        priority = { opts.priority, "number", true },
        col = { opts.col, {"number", "string"} },
    })

    local namespace_id = vim.api.nvim_create_namespace(opts.name)

    local win_col = nil
    if type(opts.col) == "number" then
        win_col = opts.col
    end

    local text_pos = "eol"
    if type(opts.col) == "number" then
        text_pos = "overlay"
    end

    -- Add the virtual lines
    local mark_ids = {}
    for _, line_opts in ipairs(opts.lines) do
        local line = line_opts.line
        local text = line_opts.text

        local mark_id = vim.api.nvim_buf_set_extmark(
            opts.bufnr,
            namespace_id,
            line,
            0,
            {
                virt_text = { { text, opts.hl } },
                virt_text_win_col = win_col,
                virt_text_pos = text_pos,
                priority = opts.priority,
            }
        )
        table.insert(mark_ids, mark_id)
    end

    local function remove()
        for _, mark_id in ipairs(mark_ids) do
            vim.api.nvim_buf_del_extmark(opts.bufnr, namespace_id, mark_id)
        end
    end

    return remove
end

return M
