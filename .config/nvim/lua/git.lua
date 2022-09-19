local self = {}

local util = require('util')
local commands = require('commands')

local gitdiff = {
    name = "GitMergeResolve",
    cmd = "Gdiffsplit!"
}

function self.setup_gitsigns()
    require('gitsigns').setup {
        signs = {
            add          = { hl = 'GitSignsAdd', text = '▐', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '▐', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '▐', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '▐', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '▐', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },

        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        },
        on_attach = function(bufnr)
            local function map(mode, lhs, rhs, opts)
                opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
                vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end

            -- Actions
            map('n', 'ga', ':Gitsigns stage_hunk<CR>')
            map('n', 'gr', ':Gitsigns reset_hunk<CR>')
            map('n', 'gu', '<cmd>Gitsigns undo_stage_hunk<CR>')

            map('n', 'gA', '<cmd>Gitsigns stage_buffer<CR>')
            map('n', 'gR', '<cmd>Gitsigns reset_buffer<CR>')

            map('n', 'gp', '<cmd>Gitsigns preview_hunk<CR>')

            map('n', 'gb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
            map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')

            map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
            map('n', '<leader>tl', '<cmd>Gitsigns toggle_linehl<CR>')

            map('v', 'sa', ':Gitsigns stage_hunk<CR>')
            map('v', 'sR', ':Gitsigns reset_hunk<CR>')

            -- Text object
            map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }

    -- Navigation
    util.setkey(")", ":lua require('gitsigns').next_hunk({navigation_message = false})<cr>")
    util.setkey("(", ":lua require('gitsigns').prev_hunk({navigation_message = false})<cr>")
    util.setkey("<leader>b", ":Gitsigns blame_line<cr>")
end

function self.setup()
    util.setkeys('n', {
        { '<leader>gp', ':Git push<cr>' },
        { '<leader>gc', ':Git commit<cr>' },
        { '<leader>gs', ':vertical bo Git<cr>' },
        { '<leader>gl', ':vsp | GcLog<cr>' },
        { '<leader>q', ':diffget //2<cr>' },
        { '<leader>w', ':diffget //3<cr>' },
    })
    self.setup_gitsigns()
    commands.register(gitdiff)
end

function self.repo_root()
    if not self.in_repo() then
        return nil
    end

    local dir, status = util.os_exec("git rev-parse --show-toplevel")
    if dir == nil or status ~= 0 then
        return nil
    end

    return dir
end

function self.in_repo()
    local _, status = util.os_exec('git branch')
    return status == 0
end

function self.branch()
    -- try branch first
    local res, status = util.os_exec('basename $(git symbolic-ref HEAD 2> /dev/null)')
    if status == 0 then
        return res
    end

    -- try commit next
    res, status = util.os_exec('git rev-list --max-count=1 HEAD')
    if status == 0 then
        return string.sub(res, 0, 6)
    end

    -- Didn't work
    return nil
end

function self.org_repo()
    local remote = util.exec('echo FugitiveRemoteUrl()')
    if remote == '' then
        return ''
    end
    return remote.match(remote, ".+[%/:](.+%/.+)$")
end


return self
