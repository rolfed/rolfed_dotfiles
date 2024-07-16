-- Directions for installing specific DAP servers
-- Go - dependencies ['delve']
--
-- List of adapters: 
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go"
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require('dapui').setup({})

        -- Go
        require("dap-go").setup({})

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
