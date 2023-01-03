-- {{{ Settings
vim.cmd([[filetype plugin indent on]])

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
vim.o.fixendofline = false
vim.o.formatoptions = "lnjqr"
vim.o.guicursor = ""
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = false
vim.o.relativenumber = false
vim.o.scrolloff = 10
vim.o.shiftwidth = 0
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.spelloptions = "noplainbuffer"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.switchbuf = "useopen"
vim.o.tabstop = 2
vim.o.textwidth = 120
vim.o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.o.undofile = true
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = false
vim.o.foldmarker = "{{{,}}}"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = '0'
vim.o.foldenable = true
vim.o.showtabline = 0
vim.cmd([[ set foldopen-=block ]])
vim.cmd([[ set foldcolumn=0 ]]) -- Not sure why this doesn't work with `vim.o`

-- }}}

-- {{{ Keymaps
local setkey = require("util").setkey
local command = require("util").command

setkey({ key = "<leader>h", cmd = ":Telescope help_tags<cr>" })
setkey({ key = "H", cmd = "^" })
setkey({ key = "L", cmd = "$" })
setkey({ key = "<A-k>", cmd = "{" })
setkey({ key = "<A-j>", cmd = "}" })
setkey({ key = "<space>", cmd = "za" })
setkey({ key = "<Tab>", cmd = ":bnext<cr>" })
setkey({ key = "<S-Tab>", cmd = ":bnext<cr>" })
setkey({ key = "<leader><space>", cmd = ":set hlsearch!<CR>" })
setkey({ mode = "i", key = "jk", cmd = "<esc>" })
setkey({ mode = "v", key = "jk", cmd = "<esc>" })
setkey({ mode = "t", key = "jk", cmd = "<c-\\><c-n>" })
setkey({ key = "<leader>fmm", cmd = ":set foldmethod=marker<CR>" })
setkey({ key = "<leader>fmi", cmd = ":set foldmethod=indent<CR>" })
setkey({ key = "<leader>fme", cmd = ":set foldmethod=expr<CR>" })
command({ key = "<C-e>", name = "FindBuffer", cmd = "Telescope buffers", })
command({ key = "<C-h>", name = "ToggleTree", cmd = "NvimTreeToggle", })
command({ key = "<leader>ev", name = "VIMRC", cmd = "e $MYVIMRC" })
command({ key = "<C-p>", name = "FindFile", cmd = function() require("telescope.builtin").find_files({ hidden = true }) end, })
command({ key = "<leader>ss", name = "FindString", cmd = "Telescope live_grep", })
command({ key = "<C-f>", name = "FindCommand", cmd = "Telescope commands" })
command({ key = "<c-space>", name = "NextDiagnostic", cmd = "lua vim.diagnostic.goto_next()" })
command({ key = "se", name = "LineErrors", cmd = "lua vim.diagnostic.open_float()", })
command({ key = "<C-d>", name = "DiagnosticsList", cmd = "TroubleToggle workspace_diagnostics", })
command({ key = "<leader>f", name = "Format", cmd = "lua vim.lsp.buf.format()" })
command({ key = "<leader>r", name = "Rename", cmd = "lua vim.lsp.buf.rename()", })
command({ key = "sd", name = "Definition", cmd = "lua vim.lsp.buf.hover()", })
command({ key = "gd", name = "GoDefinition", cmd = "Telescope lsp_definitions", })
command({ key = "sr", name = "ShowReferences", cmd = "Trouble lsp_references" })
command({ key = "<A-cr>", name = "CodeActions", cmd = "lua vim.lsp.buf.code_action()", })
command({ key = "<leader>S", name = "SearchSymbolDoc", cmd = "Telescope lsp_workspace_symbols", })
command({ key = "<leader>gs", name = "GitStatus", cmd = "vertical bo Git", })
command({ key = "<leader>gc", name = "GitCommit", cmd = "Git commit", })
command({ key = "<leader>gp", name = "GitPush", cmd = "Git push", })
command({ key = "ga", name = "GitAddHunk", cmd = "lua require('gitsigns').stage_hunk()" })
command({ key = "gr", name = "GitResetHunk", cmd = "lua require('gitsigns').reset_hunk()" })
command({ key = "gp", name = "GitPreviewHunk", cmd = "lua require('gitsigns').preview_hunk()" })
command({ key = "<leader>gl", name = "GitLog", cmd = "vsp | GcLog" })
command({ key = "gA", name = "GitAddFile", cmd = "Gitsigns stage_buffer" })
command({ key = "<C-G>", name = "Diffview", cmd = function() require('config/diffview').toggle() end})
command({ key = "<A-g>", name = "DiffHistory", cmd = "DiffviewFileHistory" })
command({ key = "<leader>td", name = "ToggleDeletedGit", cmd = "Gitsigns toggle_deleted" })
command({ key = "<leader>tl", name = "ToggleLineGit", cmd = "Gitsigns toggle_linehl" })
command({ key = "<C-t>", name = "TestToggle", cmd = "lua require('neotest').summary.toggle()" })
command({ key = "t", name = "TestFunction", cmd = "lua require('neotest').run.run()" })
command({ key = "T", name = "TestFile", cmd = "lua require('neotest').run.run(vim.fn.expand('%'))" })
command({ key = "<leader>s", name = "TestStop", cmd = "lua require('neotest').run.stop()" })
command({ key = "<C-s>", name = "Symbols", cmd = "AerialToggle" })
command({ key = "<A-t>", name = "Terminal", cmd = "ToggleTerm" })
-- }}}

-- {{{ Autocommands
vim.api.nvim_create_augroup("UserCommands", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter",
    { group = "UserCommands", command = "hi CursorLine gui=bold", }
)
vim.api.nvim_create_autocmd("InsertLeave",
    { group = "UserCommands", command = "hi CursorLine gui=NONE", }
)
-- }}}

-- {{{ Modules
-- Go before plugins
if vim.env.VIRTUAL_ENV == nil and vim.env.CONDA_PYTHON_EXE then
    vim.env.VIRTUAL_ENV = vim.env.CONDA_PYTHON_EXE
end

require("signs").setup() -- Define signs before we get to lsp
require("plugins").setup() -- Keep this first
require("lsp").setup() -- Language smarts

-- }}}
-- {{{ Colors
-- If using one dark
vim.cmd("colorscheme onedark")
vim.api.nvim_set_hl(0, "Folded", { fg = "#fa8f02", bg = "NONE", italic = true })


-- }}}
-- vim:foldmethod=marker