-- Directions for installing specific DAP servers
-- Go - dependencies ['delve']
--
-- List of adapters:
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
    },
    opts = {
        handlers = {} -- loads defaults
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require('dapui').setup({})

        -- Go
        require("dap-go").setup({})

        -- C/C++ & Rust
        dap.adapters.lldb = {
            type = 'executable',
            command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
            name = 'lldb'
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }


        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end

}
