-- {{{ Settings
vim.cmd([[filetype plugin indent on]])

vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = ","
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.backspace = "indent,eol,start"
vim.o.breakindent = true
vim.o.completeopt = "menuone,noselect,menu"
vim.o.concealcursor = ""
vim.o.conceallevel = 2
vim.o.cursorline = true
vim.o.cursorlineopt = "both"
vim.o.expandtab = true
vim.o.fillchars = "fold: ,foldclose: ,foldopen: ,foldsep: ,diff: ,eob: "
vim.o.list = true
vim.o.listchars = "tab:▸ ,trail:·,nbsp:␣,extends:❯,precedes:❮"
vim.o.fixendofline = false
vim.o.formatoptions = "lnjqr"
vim.o.guicursor = ""
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.scrolloff = 5
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.spelloptions = "camel"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.switchbuf = "uselast"
vim.o.textwidth = 120
vim.o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.o.undofile = true
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = false
vim.o.foldmarker = "{{{,}}}"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext = "getline(v:foldstart)"
vim.o.foldcolumn = "0"
vim.o.foldenable = false
vim.o.showtabline = 0
vim.o.display = "lastline"
vim.o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
vim.cmd([[ set foldopen-=all ]])
vim.cmd([[ set foldcolumn=0 ]]) -- Not sure why this doesn't work with `vim.o`

vim.opt.laststatus = 2 -- Or 3 for global statusline
vim.opt.statusline = " %f %m %= %l:%c ♥ "

vim.g.zig_fmt_parse_errors = 0

if vim.g.neovide then
    print("Setting neovide settings")
    vim.o.linespace = 5
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_cursor_animation_length = 0.065
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
end

-- }}}
-- {{{ Keymaps
local setkey = require("util").setkey
local command = require("util").command

-- jk
setkey({ mode = "i", key = "jk", cmd = "<esc>" })
setkey({ mode = "v", key = "q", cmd = "<esc>" })
setkey({ mode = "t", key = "jk", cmd = "<c-\\><c-n>" })

-- Visiual
setkey({ mode = "v", key = ">", cmd = ">gv" })
setkey({ mode = "v", key = "<", cmd = "<gv" })

-- Normal
setkey({ key = "H", cmd = "^" })
setkey({ key = "L", cmd = "$" })
setkey({ key = "<A-k>", cmd = "{zz" })
setkey({ key = "<A-j>", cmd = "}zz" })
setkey({ key = "[f", cmd = "[fzt" })
setkey({ key = "]f", cmd = "]fzt" })
setkey({ key = "[[", cmd = "[[zt" })
setkey({ key = "]]", cmd = "]]zt" })
setkey({ key = "<C-o>", cmd = "<C-o>zz" })
setkey({ key = "cl", cmd = "cgn" })
setkey({ key = "<space>", cmd = "za" })
setkey({ key = "<leader><space>", cmd = ":set hlsearch!<CR>" })
command({ key = "<leader>ev", name = "VIMRC", cmd = "e $MYVIMRC" })

-- Telescope
setkey({ key = "<leader>h", cmd = ":Telescope help_tags<cr>" })
command({ key = "<C-e>", name = "FindBuffer", cmd = "Telescope buffers" })
command({ key = "<C-k>", name = "Commands", cmd = "Telescope commands" })
command({
    key = "<C-p>",
    name = "FindFile",
    cmd = function()
        require("telescope.builtin").find_files({ hidden = true })
    end,
})
command({
    key = "<leader>ss",
    name = "FindString",
    cmd = function()
        require("telescope.builtin").live_grep({ disable_coordinates = true })
    end,
})

-- Tree
command({ key = "<C-h>", name = "TreeToggle", cmd = "NvimTreeToggle" })
command({
    key = "<c-space>",
    name = "NextDiagnostic",
    cmd = function()
        vim.cmd("normal zR") -- Expand folds
        vim.diagnostic.goto_next({ wrap = true })
    end,
})

command({
    key = "<leader>sg",
    name = "ShowHighlight",
    cmd = function()
        print(vim.show_pos())
    end,
})
command({
    key = "<C-n>",
    name = "ToggleNumbers",
    cmd = "set relativenumber! | set number!",
})

-- Git stuffs
command({ key = "<leader>gs", name = "GitStatus", cmd = "vertical bo Git" })
command({ key = "<leader>gc", name = "GitCommit", cmd = "Git commit" })
command({ key = "<leader>gp", name = "GitPush", cmd = "Git push" })
command({
    key = "ga",
    name = "GitAddHunk",
    cmd = "lua require('gitsigns').stage_hunk()",
})
command({
    key = "gr",
    name = "GitResetHunk",
    cmd = "lua require('gitsigns').reset_hunk()",
})
command({ key = "<leader>gl", name = "GitLog", cmd = "vsp | GcLog" })
command({ key = "gA", name = "GitAddFile", cmd = "Gitsigns stage_buffer" })
command({
    key = "<C-G>",
    name = "Diffview",
    cmd = function()
        require("config/diffview").toggle()
    end,
})
command({ key = "<A-g>", name = "DiffHistory", cmd = "DiffviewFileHistory" })
command({
    key = "<leader>td",
    name = "ToggleDeletedGit",
    cmd = "Gitsigns toggle_deleted",
})
command({ key = "<leader>tl", name = "ToggleLineGit", cmd = "Gitsigns toggle_linehl" })
command({ key = "<leader>gb", name = "GitBranches", cmd = "Telescope git_branches" })
setkey({ key = "<leader>gB", cmd = ":Git checkout -b " })

-- Mayb want these back

-- word variants
vim.api.nvim_set_keymap("n", "sb", "ysiw)i", { silent = true })
vim.api.nvim_set_keymap("n", "s", "ysiw", { silent = true })
-- WORD variants
vim.api.nvim_set_keymap("n", "Sb", "ysiW)i", { silent = true })
vim.api.nvim_set_keymap("n", "S", "ysiW", { silent = true })

vim.api.nvim_set_keymap(
    "x",
    "gc",
    "<Plug>comment_toggle_linewise_visual",
    { silent = true }
)

vim.api.nvim_create_augroup("UserLocList", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "UserLocList",
    pattern = "qf",
    command = "nnoremap <buffer> j j<cr>zt<c-w>p",
})
vim.api.nvim_create_autocmd("FileType", {
    group = "UserLocList",
    pattern = "qf",
    command = "nnoremap <buffer> k k<cr>zt<c-w>p",
})
-- }}}
-- {{{ Autocommands
vim.api.nvim_create_augroup("UserCommands", { clear = true })
vim.api.nvim_create_autocmd(
    "InsertEnter",
    { group = "UserCommands", command = "hi CursorLine gui=bold" }
)
vim.api.nvim_create_autocmd(
    "InsertLeave",
    { group = "UserCommands", command = "hi CursorLine gui=NONE" }
)
vim.api.nvim_create_autocmd(
    "TermOpen",
    { group = "UserCommands", command = "setlocal nonumber norelativenumber" }
)
vim.api.nvim_create_autocmd(
    "TermOpen",
    { group = "UserCommands", command = "startinsert" }
)
vim.api.nvim_create_autocmd(
    "TermOpen",
    { group = "UserCommands", command = "nnoremap <buffer> <C-c> i<C-c>" }
)

-- {{{ Modules
-- Go before plugins
if vim.env.VIRTUAL_ENV == nil and vim.env.CONDA_PYTHON_EXE then
    vim.env.VIRTUAL_ENV = vim.env.CONDA_PYTHON_EXE
end

require("plugins").setup() -- Keep this first

-- }}}
-- {{{ Colors
vim.api.nvim_create_autocmd("VimEnter", {
    group = "UserCommands",
    callback = function(event)
        require("rose-pine").colorscheme("moon")
    end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "UserCommands",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Cursor", timeout = 60 })
    end,
})

vim.api.nvim_set_hl(0, "Folded", { bg = "#353b4e", italic = true })
-- vim:foldmethod=marker
