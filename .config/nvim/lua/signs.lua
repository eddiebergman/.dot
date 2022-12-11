local M = {}

function M.get_sign(name)
    return vim.fn.sign_getdefined(name)[1].text
end

function M.set_sign(opts)
    vim.validate({
        name = { opts.name, "string" },
        sign = { opts.sign, "string" },
        hl = { opts.hl, "string", true }
    })
    vim.fn.sign_define(opts.name, {
        text = opts.sign,
        texthl = opts.hl or opts.name,
        numhl = ""
    })
end

M.signs = {
    info = ' ',
    warn = ' ',
    error = ' ',
    hint = '',
}

function M.setup()
    M.set_sign({ name = 'DiagnosticSignError', sign = M.signs.error })
    M.set_sign({ name = 'DiagnosticSignWarn', sign = M.signs.warn })
    M.set_sign({ name = 'DiagnosticSignHint', sign = M.signs.hint })
    M.set_sign({ name = 'DiagnosticSignInfo', sign = M.signs.info })
    M.set_sign({ name = 'Error', sign = M.signs.error, hl = "Error" })
    M.set_sign({ name = 'Warn', sign = M.signs.warn, hl = "WarningMsg" })
    M.set_sign({ name = 'Hint', sign = M.signs.hint,  hl = "DiagnosticHint" })
    M.set_sign({ name = 'Info', sign = M.signs.info, hl = "DiagnosticInfo" })
end

return M
