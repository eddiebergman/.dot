local M = {}


function M.setup()
    if vim.o.showtabline == 0 then
        return
    end
    require("bufferline").setup({
        options = {
            mode = "buffers",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = function()
                        return vim.api.nvim_exec(":echo fnamemodify(getcwd(), ':t')", true)
                    end,
                    highlight = "Title",
                    text_align = "left",
                }
            },
            always_show_bufferline = false,
            show_close_icon = false,
            seperator_style = 'thick',
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level)
                local icon = level:match('error') and ' ' or ''
                return ' ' .. icon .. count
            end,
        },
    })
end

return M
