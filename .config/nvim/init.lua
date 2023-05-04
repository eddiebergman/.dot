-- {{{ Settings
vim.cmd([[filetype plugin indent on]])

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
vim.o.inccommand = "nosplit"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.mouse = "a"
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
vim.o.cmdheight = 0
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
vim.cmd([[ set foldopen-=block ]])
vim.cmd([[ set foldcolumn=0 ]]) -- Not sure why this doesn't work with `vim.o`

if vim.g.neovide then
    vim.o.guifont = "FiraCode Nerd Font:h15:e-subpixelantialias"
    vim.o.linespace = 5
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_cursor_animation_length = 0.065
    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function() change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-_>", function() change_scale_factor(1/1.25)
    end)

end

-- }}}

-- {{{ Keymaps
local setkey = require("util").setkey
local command = require("util").command

setkey({ key = "<leader>h", cmd = ":Telescope help_tags<cr>" })
setkey({ key = "H", cmd = "^" })
setkey({ key = "L", cmd = "$" })
setkey({ key = "<A-k>", cmd = "<C-u>zz" })
setkey({ key = "<A-j>", cmd = "<C-d>zz" })
--setkey({ mode = "v", key = "<A-k>", cmd = "<C-u>zz" })
--setkey({ mode = "v", key = "<A-j>", cmd = "<C-d>zz" })
setkey({ key = "<C-o>", cmd = "<C-o>zz" })
setkey({ mode = "v", key = "<A-j>", cmd = "xp`[V`]" })
setkey({ mode = "v", key = "<A-k>", cmd = "xkP`[V`]" })
setkey({ mode = "v", key = ">", cmd = ">gv" })
setkey({ mode = "v", key = "<", cmd = "<gv" })
setkey({ key = "cl", cmd = "cgn" })
--setkey({ key = "<C-k>", cmd = "<C-u>" })
--setkey({ key = "<C-j>", cmd = "<C-d>" })

setkey({ key = "<space>", cmd = "za" })
setkey({ key = "<Tab>", cmd = ":bnext<cr>" })
setkey({ key = "<S-Tab>", cmd = ":bnext<cr>" })
setkey({ key = "<leader><space>", cmd = ":set hlsearch!<CR>" })
setkey({ mode = "i", key = "jk", cmd = "<esc>" })
setkey({ mode = "v", key = "q", cmd = "<esc>" })
setkey({ mode = "t", key = "jk", cmd = "<c-\\><c-n>" })
setkey({ key = "<leader>fmm", cmd = ":set foldmethod=marker<CR>" })
setkey({ key = "<leader>fmi", cmd = ":set foldmethod=indent<CR>" })
setkey({ key = "<leader>fme", cmd = ":set foldmethod=expr<CR>" })
command({ key = "<C-e>", name = "FindBuffer", cmd = "Telescope buffers", })
command({ key = "<C-h>", name = "ToggleTree", cmd = "NvimTreeToggle", })
command({ key = "<leader>ev", name = "VIMRC", cmd = "e $MYVIMRC" })
command({ key = "<C-p>", name = "FindFile",
    cmd = function() require("telescope.builtin").find_files({ hidden = true }) end, })
command({ key = "<leader>ss", name = "FindString", cmd = "Telescope live_grep", })
command({
    key = "<c-space>",
    name = "NextDiagnostic",
    cmd = function()
        vim.cmd("normal! zR") -- Expand folds
        vim.diagnostic.goto_next({ wrap = true, })
    end
})
command({ key = "se", name = "LineErrors", cmd = "lua vim.diagnostic.open_float()", })
command({ key = "<C-d>", name = "DiagnosticsList", cmd = "TroubleToggle workspace_diagnostics", })

command({ key = "cc", name = "RenameSymbol", cmd = "lua vim.lsp.buf.rename()" })
command({ key = "<leader>f", name = "Format", cmd = "lua vim.lsp.buf.format()" })
command({ key = "sd", name = "Definition", cmd = "lua vim.lsp.buf.hover()", })
command({ key = "gd", name = "GoDefinition", cmd = "Telescope lsp_definitions", })
command({ key = "gi", name = "GoImplementation", cmd = "Telescope lsp_implementations", })
command({ key = "sr", name = "ShowReferences", cmd = "Trouble lsp_references" })
command({ key = "<A-cr>", name = "CodeActions", cmd = "lua vim.lsp.buf.code_action()", })
command({ key = "<leader>S", name = "SearchSymbolDoc", cmd = "Telescope lsp_workspace_symbols", })
command({
    key = "<leader>sg",
    name = "ShowHighlight",
    cmd = function() print(vim.show_pos()) end
})

command({ key = "<C-n>", name = "ToggleNumbers", cmd = "set relativenumber! | set number!" })

command({ key = "<leader>gs", name = "GitStatus", cmd = "vertical bo Git", })
command({ key = "<leader>gc",  name = "GitCommit", cmd = "Git commit", })
command({ key = "<leader>gp", name = "GitPush", cmd = "Git push", })
command({ key = "ga", name = "GitAddHunk", cmd = "lua require('gitsigns').stage_hunk()" })
command({ key = "gr", name = "GitResetHunk", cmd = "lua require('gitsigns').reset_hunk()" })
command({ key = "gp", name = "GitPreviewHunk", cmd = "lua require('gitsigns').preview_hunk()" })
command({ key = "<leader>gl", name = "GitLog", cmd = "vsp | GcLog" })
command({ key = "gA", name = "GitAddFile", cmd = "Gitsigns stage_buffer" })
command({ key = "<C-G>", name = "Diffview", cmd = function() require('config/diffview').toggle() end })
command({ key = "<A-g>", name = "DiffHistory", cmd = "DiffviewFileHistory" })
command({ key = "<leader>td", name = "ToggleDeletedGit", cmd = "Gitsigns toggle_deleted" })
command({ key = "<leader>tl", name = "ToggleLineGit", cmd = "Gitsigns toggle_linehl" })

command({ key = "<C-t>", name = "TestToggle", cmd = "lua require('neotest').summary.toggle()" })
command({ key = "t", name = "TestFunction", cmd = "lua require('neotest').run.run()" })
command({ key = "T", name = "TestFile", cmd = "lua require('neotest').run.run(vim.fn.expand('%'))" })

command({ key = "<C-s>", name = "Symbols", cmd = "AerialToggle" })
command({ key = "<A-t>", name = "Terminal", cmd = "ToggleTerm" })
command({ key = "<leader>lr", name = "ToggleLspReferences", cmd = function() vim.diagnostic.reset() end })

command({
    key = "<leader>b",
    name = "BrowseBookmarks",
    cmd = function() require("browse").browse() end
})
command({
    key = "<leader>w",
    name = "BrowseWeb",
    cmd = function() require("browse").input_search() end,
})
command({
    key = "<leader>dd",
    name = "BrowseDevDocs",
    cmd = function() require("browse.devdocs").search_with_filetype() end,
})

setkey({ key = "Q", cmd = "@q" })
command({ key = "Z", name = "Zen", cmd = "ZenMode" })
command({ key = "M", name = "HarpoonMark", cmd = function() require("harpoon.mark").add_file() end })
command({ key = "mm", name = "HarpoonView", cmd = function() require("harpoon.ui").toggle_quick_menu() end })

command({ key = "<leader>1", name = "HarpoonNav1", cmd = function() require("harpoon.ui").nav_file(1) end })
command({ key = "<leader>2", name = "HarpoonNav2", cmd = function() require("harpoon.ui").nav_file(2) end })
command({ key = "<leader>3", name = "HarpoonNav3", cmd = function() require("harpoon.ui").nav_file(3) end })
command({ key = "<leader>4", name = "HarpoonNav4", cmd = function() require("harpoon.ui").nav_file(4) end })

command({ key = "mn", name = "HarpoonNavNext", cmd = function() require("harpoon.ui").nav_next() end })
command({ key = "mp", name = "HarpoonNavPrev", cmd = function() require("harpoon.ui").nav_prev() end })

command({ key = "<leader>qs", name = "SessionLoad", cmd = function() require("persistence").load() end })

command({ key = "<C-f>", name = "RunCmd", cmd = "OverseerRun" })
command({ key = "<C-x>", name = "ToggleOverseer", cmd = "OverseerToggle" })


vim.api.nvim_set_keymap("n", "<leader>sn", "<Plug>(SpotifySkip)", { silent = true }) -- Skip the current track
vim.api.nvim_set_keymap("n", "<leader>sp", "<Plug>(SpotifyPause)", { silent = true }) -- Pause/Resume the current track
vim.api.nvim_set_keymap("n", "<leader>s<C-s>", "<Plug>(SpotifySave)", { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap("n", "<leader>so", ":Spotify<CR>", { silent = true }) -- Open Spotify Search window
vim.api.nvim_set_keymap("n", "<leader>sd", ":SpotifyDevices<CR>", { silent = true }) -- Open Spotify Devices window
vim.api.nvim_set_keymap("n", "<leader>sp", "<Plug>(SpotifyPrev)", { silent = true }) -- Go back to the previous track
vim.api.nvim_set_keymap("n", "<leader>sh", "<Plug>(SpotifyShuffle)", { silent = true }) -- Toggles shuffle mode

-- }}}
-- {{{ Autocommands
vim.api.nvim_create_augroup("UserCommands", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter",
    { group = "UserCommands", command = "hi CursorLine gui=bold", }
)
vim.api.nvim_create_autocmd("InsertLeave",
    { group = "UserCommands", command = "hi CursorLine gui=NONE", }
)
vim.api.nvim_create_autocmd("TermOpen",
    { group = "UserCommands", command = "setlocal nonumber norelativenumber", }
)
vim.api.nvim_create_autocmd("TermOpen",
    { group = "UserCommands", command = "startinsert", }
)
vim.api.nvim_create_autocmd("TermOpen",
    { group = "UserCommands", command = "nnoremap <buffer> <C-c> i<C-c>", }
)

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
local colorscheme = "darkme"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_enable_bold = false
vim.g.gruvbox_material_transparent_background = 0
vim.g.gruvbox_material_dim_inactive_windows = false
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_better_performance = 'colored'

vim.cmd("colorscheme " .. colorscheme)

-- }}}
-- Custom plugin

local vtexts = {}
function do_vtext_lines()

    local theme = require("lush_theme.darkme")

    local lines_to_hl = { 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60 }
    for _, i in ipairs(lines_to_hl) do
        local name = "RN" .. i
        local color = theme.VertSplit.fg
        vim.api.nvim_set_hl(0, name,
            { fg = tostring(theme.StatusLine.fg), bg = tostring(color), bold = true, }
        )
        vim.fn.sign_define(name, { numhl = name })
    end
    RNgroup = "RelativeNumbersHL"

    local vtext = require("vtext")
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        callback = function()
            local name = "demo"
            local bufnr = vim.api.nvim_get_current_buf()
            local winnr = vim.api.nvim_get_current_win()
            local current_line = vim.api.nvim_win_get_cursor(winnr)[1] - 1
            local line_count = vim.api.nvim_buf_line_count(bufnr)

            if vtexts[name] then

                local named_vtexts = vtexts[name]
                if named_vtexts[bufnr] then
                    local remove = named_vtexts[bufnr]
                    remove()
                end

            else
                vtexts[name] = {}
            end

            local lines = {}
            for _, line_nr in ipairs(lines_to_hl) do
                local upper_offset = current_line - line_nr
                local lower_offset = current_line + line_nr
                local txt = " " .. tostring(line_nr) .. " "
                if string.len(txt) == 1 then
                    txt = " " .. txt
                end

                for _, offests in ipairs({ upper_offset, lower_offset }) do
                    if offests > 0 and offests <= line_count - 1 then
                        local line_text_length = string.len(vim.api.nvim_buf_get_lines(bufnr, offests, offests + 1, true)
                            [1])
                        if line_text_length > 0 then
                            table.insert(lines, { line = offests, text = txt })
                        end
                    end
                end
            end


            local remove = vtext.add({
                name = "demo",
                bufnr = bufnr,
                lines = lines,
                hl = "RN5",
                col = "eol",
            })
            vtexts[name][bufnr] = remove
        end,
    })
end

-- vim:foldmethod=marker
