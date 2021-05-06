require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = { priority = 4 },
        ultisnips = { priority = 3 },
        nvim_lsp = { priority = 2 },
        buffer = { priority = 1 },
        nvim_lua = true,
        calc = false,
    }
}

vim.api.nvim_exec(
[[
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"
]] ,true)

