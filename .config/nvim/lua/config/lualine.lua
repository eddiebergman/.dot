local M = {}
local lualine = require("lualine")

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end


local recording_mode = { "recording", fmt = show_macro_recording }

vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
    callback = function() lualine.refresh({ place = {"statusline"} }) end,
})

vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
            30,
            0,
            vim.schedule_wrap(function() lualine.refresh({ place = {"statusline"} }) end)
        )
        timer:close()
    end,
})


local lsp_progress = {
    'lsp_progress',
    display_components = { 'lsp_client_name', "spinner" },
    separators = {
        component = '',
        progress = ' | ',
        message = { pre = '(', post = ')' },
        percentage = { pre = '', post = '%% ' },
        title = { pre = '', post = ': ' },
        lsp_client_name = { pre = '', post = ' - ' },
        spinner = { pre = '', post = '' },
    },
    timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
    spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
}

function M.setup()
    lualine.setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = { "NvimTree", "Trouble" },
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode', recording_mode },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { lsp_progress },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end

return M
