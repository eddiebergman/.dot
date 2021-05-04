local chadtree_settings = {
    ignore = {
        name_exact= {"__pycache__"}
    },
    theme = {
        icon_glyph_set = "ascii",
        text_colour_set = "solarized_dark",
    },
    keymap = {
        primary = {"o"},
        secondary = {"<S-o>"},
        open_sys = {"<C-o>"},
        collapse = {"<space>"}
    }
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
