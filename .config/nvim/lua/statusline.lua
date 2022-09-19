local self = {}

local bufferline_config = {
    options = {
        indicator = { icon = "▎" },
        separator_style = { "", "" },
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        offsets = {
            { filetype = "NvimTree", }
        },
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                    or (e == "warning" and " " or "")
                s = s .. n .. sym
            end
            return s
        end,
    },
}

local lualine_config = {
    theme = "tokyonight"
}

function self.setup()
    require("bufferline").setup(bufferline_config)
    require("lualine").setup(lualine_config)
end

return self
