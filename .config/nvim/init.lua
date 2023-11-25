-- {{{ Settings
vim.cmd([[filetype plugin indent on]])


vim.o.number = false
vim.o.relativenumber = false
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
vim.o.foldtext = "getline(v:foldstart)"
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
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-_>", function()
        change_scale_factor(1 / 1.25)
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
command({ key = "<C-k>", name = "Commands", cmd = "Telescope commands" })
command({ key = "<C-h>", name = "ToggleTree", cmd = "NvimTreeToggle", })
command({ key = "<leader>ev", name = "VIMRC", cmd = "e $MYVIMRC" })
command({
    key = "<C-p>",
    name = "FindFile",
    cmd = function() require("telescope.builtin").find_files({ hidden = true }) end,
})
command({ key = "<leader>ss", name = "FindString", cmd = "Telescope live_grep", })
command({
    key = "<c-space>",
    name = "NextDiagnostic",
    cmd = function()
        vim.cmd("normal! zR") -- Expand folds
        vim.diagnostic.goto_next({ wrap = true, })
    end
})

command({
    key = "<down>",
    name = "NextPreview",
    cmd = function()
        local glib = require("goto-preview.lib")

        local windows = glib.windows
        local current_win = vim.api.nvim_get_current_win()

        -- If windows is empty, do nothing
        if #windows == 0 then
            return
        end

        function tablefind(tab, el)
            for index, value in pairs(tab) do
                if value == el then
                    return index
                end
            end
        end

        local index = tablefind(windows, current_win)
        if index then
            local next_win = windows[index + 1]
            if next_win then
                vim.api.nvim_set_current_win(next_win)
            else
                vim.api.nvim_set_current_win(windows[1])
            end
        else
            vim.api.nvim_set_current_win(windows[1])
        end
    end
})
command({
    key = "<up>",
    name = "PreviousPreview",
    cmd = function()
        local glib = require("goto-preview.lib")

        local windows = glib.windows
        local current_win = vim.api.nvim_get_current_win()

        -- If windows is empty, do nothing
        if #windows == 0 then
            return
        end

        function tablefind(tab, el)
            for index, value in pairs(tab) do
                if value == el then
                    return index
                end
            end
        end

        local index = tablefind(windows, current_win)
        if index then
            local next_win_index = index - 1
            if next_win_index < 1 then
                next_win_index = #windows
            end
            local next_win = windows[next_win_index]
            if next_win then
                vim.api.nvim_set_current_win(next_win)
            else
                vim.api.nvim_set_current_win(windows[1])
            end
        else
            vim.api.nvim_set_current_win(windows[1])
        end
    end
})

command({ key = "se", name = "LineErrors", cmd = "lua vim.diagnostic.open_float()", })
command({ key = "<C-d>", name = "DiagnosticsList", cmd = "TroubleToggle workspace_diagnostics", })

command({ key = "cc", name = "RenameSymbol", cmd = "lua vim.lsp.buf.rename()" })
command({
    key = "<leader>f",
    name = "Format",
    cmd = function()
        vim.lsp.buf.format()
        vim.cmd("RuffOrganizeImports")
        vim.cmd("normal! zR") -- Expand folds
    end
})
command({ key = "sd", name = "Definition", cmd = "lua vim.lsp.buf.hover()", })
command({ key = "gd", name = "GoDefinition", cmd = "Telescope lsp_definitions", })
command({
    key = "<leader>v",
    name = "GoDefinitionVsplit",
    cmd = function() require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" }) end,
})
command({ key = "gi", name = "GoImplementation", cmd = "Telescope lsp_implementations", })
command(
    {
        key = "gp",
        name = "GoPeek",
        cmd = function()
            require('goto-preview').goto_preview_definition()
            vim.cmd("normal! zR") -- Expand folds
        end
    })
command(
    {
        key = "Q",
        name = "CloseAllPeek",
        cmd = function()
            require('goto-preview').close_all_win()
        end
    })
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
command({ key = "<leader>gc", name = "GitCommit", cmd = "Git commit", })
command({ key = "<leader>gp", name = "GitPush", cmd = "Git push", })
command({ key = "ga", name = "GitAddHunk", cmd = "lua require('gitsigns').stage_hunk()" })
command({ key = "gr", name = "GitResetHunk", cmd = "lua require('gitsigns').reset_hunk()" })
command({ key = "<leader>gl", name = "GitLog", cmd = "vsp | GcLog" })
command({ key = "gA", name = "GitAddFile", cmd = "Gitsigns stage_buffer" })
command({ key = "<C-G>", name = "Diffview", cmd = function() require('config/diffview').toggle() end })
command({ key = "<A-g>", name = "DiffHistory", cmd = "DiffviewFileHistory" })
command({ key = "<leader>td", name = "ToggleDeletedGit", cmd = "Gitsigns toggle_deleted" })
command({ key = "<leader>tl", name = "ToggleLineGit", cmd = "Gitsigns toggle_linehl" })
command({ key = "<leader>gb", name = "GitBranches", cmd = "Telescope git_branches" })
vim.api.nvim_set_keymap("n", "<leader>gB", ":Git checkout -b ", { silent = True} )

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


vim.api.nvim_set_keymap("n", "<leader>sn", "<Plug>(SpotifySkip)", { silent = true })     -- Skip the current track
vim.api.nvim_set_keymap("n", "<leader>sp", "<Plug>(SpotifyPause)", { silent = true })    -- Pause/Resume the current track
vim.api.nvim_set_keymap("n", "<leader>s<C-s>", "<Plug>(SpotifySave)", { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap("n", "<leader>so", ":Spotify<CR>", { silent = true })            -- Open Spotify Search window
vim.api.nvim_set_keymap("n", "<leader>sd", ":SpotifyDevices<CR>", { silent = true })     -- Open Spotify Devices window
vim.api.nvim_set_keymap("n", "<leader>sp", "<Plug>(SpotifyPrev)", { silent = true })     -- Go back to the previous track
vim.api.nvim_set_keymap("n", "<leader>sh", "<Plug>(SpotifyShuffle)", { silent = true })  -- Toggles shuffle mode

vim.api.nvim_set_keymap("n", "S", "ys", { silent = true })  -- Toggles shuffle mode
vim.api.nvim_set_keymap("x", "gc", "<Plug>comment_toggle_linewise_visual", { silent = true })



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

require("signs").setup()   -- Define signs before we get to lsp
require("plugins").setup() -- Keep this first
require("lsp").setup()     -- Language smarts

-- }}}
-- {{{ Colors
-- If using one dark
--local colorscheme = "gruvbox-material"
local colorscheme = "gruvbox-material"
-- Gruvbox
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_enable_bold = true
vim.g.gruvbox_material_dim_inactive_windows = false
vim.g.gruvbox_material_diagnostic_text_highlight = true
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_diagnostic_line_highlight = true
vim.g.gruvbox_material_diagnostic_word_highlight = true
vim.g.gruvbox_material_better_performance = true
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_menu_selection_background = "red"

-- Get color of current background
local normal_bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
local normal_fg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "fg")
local guide = "#d02670"

-- Set highlight of FloatBoard
vim.cmd("colorscheme " .. colorscheme)
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = normal_bg, fg = guide })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal_bg, fg = normal_fg })
-- vim.api.nvim_set_hl(0, "Folded", { bg = normal_bg, fg = guide, italic = false })
vim.api.nvim_set_hl(0, "Folded", { bg = normal_bg, fg = guide, italic = false })
vim.api.nvim_set_hl(0, "SignColumn", { bg = normal_bg })
vim.api.nvim_set_hl(0, "SpellBad", { sp = "#a832a2", undercurl = true })

-- vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = guide })

-- Get the highlight for visual selection
local visual_bg = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg")
-- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = visual_bg })
print(normal_bg)

-- Set the winsep border highlight
-- vim.api.nvim_set_hl(0, "WinSep", { bg = normal_bg, fg = guide })
-- vim.api.nvim_set_hl(0, "WinSepNC", { bg = normal_bg, fg = guide })
-- vim.api.nvim_set_hl(0, "VertSplit", { bg = normal_bg, fg = guide })

-- Set the inactive window statusline highlight
-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#171117", fg = guide })

-- }}}

-- vim:foldmethod=marker
