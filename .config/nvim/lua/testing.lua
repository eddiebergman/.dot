local self = {}
local neotest = require("neotest")

local util = require('util')

self.keymaps = {
    n = {
        {"<C-t>", "<cmd>lua require('neotest').summary.toggle()<CR>"},
        {"tt", "<cmd>lua require('neotest').run.run()<CR>"},
        {"to", "<cmd>lua require('neotest').output.open({enter = true, short = true})<CR>"},
        {"ts", "<cmd>lua require('neotest').run.stop()<CR>"},
    }
}

function self.setup()
    for mode, keys in pairs(self.keymaps) do
        util.setkeys(mode, keys)
    end

    neotest.setup({
        adapters = {
            require("neotest-python")({
                args = {"--log-level", "DEBUG", "--color", "yes"}
            })
        },
        consumers = {},
        diagnostic = {
          enabled = true
        },
        discovery = {
          enabled = true
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
          options = {}
        },
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest"
        },
        icons = {
          child_indent = " ",
          child_prefix = "|",
          collapsed = "",
          expanded = "",
          failed = "x",
          final_child_indent = " ",
          final_child_prefix = "|",
          non_collapsible = "",
          passed = "o",
          running = "*",
          skipped = "-",
          unknown = ""
        },
        jump = {
          enabled = true
        },
        output = {
          enabled = true,
          open_on_run = "short"
        },
        run = {
          enabled = true
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = false
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120
          }
        },
        summary = {
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            expand = { "<space>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            output = "o",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t"
          }
        }
      }
    )
end

return self

