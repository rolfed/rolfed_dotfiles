return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      -- Main leader key groups
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>e", group = "Errors/Diagnostics" },
      { "<leader>ee", desc = "Show error details" },
      { "<leader>en", desc = "Next error" },
      { "<leader>ep", desc = "Previous error" },
      { "<leader>eq", desc = "Local error list" },
      { "<leader>eQ", desc = "Global error list" },
      { "<leader>f", group = "Find/Format" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>j", group = "Java" },
      { "<leader>l", group = "LSP" },
      { "<leader>m", group = "Marks" },
      { "<leader>n", group = "Notes" },
      { "<leader>p", group = "Project" },
      { "<leader>q", group = "Quickfix" },
      { "<leader>r", group = "Refactor" },
      { "<leader>s", group = "Search/Split" },
      { "<leader>t", group = "Test/Toggle" },
      { "<leader>u", group = "UI/Undo" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Trouble/Diagnostics" },

      -- Git subgroups
      { "<leader>gh", group = "GitHub" },

      -- Java subgroups and commands
      { "<leader>jo", desc = "Organize imports" },
      { "<leader>jv", desc = "Extract variable" },
      { "<leader>jc", desc = "Extract constant" },
      { "<leader>jm", desc = "Extract method" },
      { "<leader>jt", group = "Test" },
      { "<leader>jtc", desc = "Test class" },
      { "<leader>jtn", desc = "Test nearest method" },
      { "<leader>jd", group = "Debug" },
      { "<leader>jdc", desc = "Debug class" },
      { "<leader>jdn", desc = "Debug nearest method" },

      -- LSP subgroups and commands
      { "<leader>la", group = "Actions" },
      { "<leader>lw", group = "Workspace" },
      { "<leader>lwa", desc = "Add workspace folder" },
      { "<leader>lwr", desc = "Remove workspace folder" },
      { "<leader>lwl", desc = "List workspace folders" },
      { "<leader>li", desc = "LSP info" },
      { "<leader>lr", desc = "Restart LSP" },
      { "<leader>ls", desc = "Document symbols" },
      { "<leader>lS", desc = "Workspace symbols" },
      { "<leader>lf", desc = "Format buffer/selection" },
      { "<leader>lh", desc = "Toggle inlay hints" },

      -- Code actions (dynamically mapped when LSP attaches)
      { "<leader>rn", desc = "Rename symbol" },
      { "<leader>ca", desc = "Code action" },

      -- Notes (Obsidian) subgroups
      { "<leader>nd", group = "Daily" },
      { "<leader>nw", group = "Weekly" },

      -- Project subgroups
      { "<leader>ps", group = "Sessions" },
      { "<leader>pv", group = "Explorer" },

      -- Test subgroups
      { "<leader>tt", group = "Test Run" },
      { "<leader>td", group = "Test Debug" },

      -- UI/Toggle subgroups
      { "<leader>ut", group = "Toggle" },

      -- Window management
      { "<leader>wv", desc = "Split window vertically" },
      { "<leader>wh", desc = "Split window horizontally" },
      { "<leader>we", desc = "Make splits equal size" },
      { "<leader>wx", desc = "Close current split" },
      { "<leader>wo", desc = "Close other splits" },
      { "<leader>ww", desc = "Switch between splits" },
      { "<leader>wj", desc = "Move to split below" },
      { "<leader>wk", desc = "Move to split above" },
      { "<leader>wl", desc = "Move to split right" },
      { "<leader>wr", desc = "Rotate splits downward/right" },
      { "<leader>wR", desc = "Rotate splits upward/left" },
      { "<leader>wH", desc = "Move split to far left" },
      { "<leader>wJ", desc = "Move split to bottom" },
      { "<leader>wK", desc = "Move split to top" },
      { "<leader>wL", desc = "Move split to far right" },
      { "<leader>w<", desc = "Decrease width" },
      { "<leader>w>", desc = "Increase width" },
      { "<leader>w-", desc = "Decrease height" },
      { "<leader>w+", desc = "Increase height" },

      -- Bracket mappings
      { "]", group = "Next" },
      { "[", group = "Previous" },
      { "]d", desc = "Next diagnostic" },
      { "[d", desc = "Previous diagnostic" },
      { "]f", desc = "Next function start" },
      { "[f", desc = "Previous function start" },
      { "]F", desc = "Next function end" },
      { "[F", desc = "Previous function end" },
      { "]c", desc = "Next class start" },
      { "[c", desc = "Previous class start" },
      { "]C", desc = "Next class end" },
      { "[C", desc = "Previous class end" },
      { "]a", desc = "Next parameter" },
      { "[a", desc = "Previous parameter" },

      -- Goto mappings (LSP)
      { "g", group = "Goto" },
      { "gd", desc = "Go to definition" },
      { "gD", desc = "Go to declaration" },
      { "gi", desc = "Go to implementation" },
      { "gt", desc = "Go to type definition" },
      { "gr", desc = "Go to references" },
      { "K", desc = "Hover documentation" },
      { "<C-k>", desc = "Signature help" },
      { "gz", group = "Surround" },

      -- Mode-specific groups
      { "<leader>", group = "Leader", mode = { "n", "v" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)"
    }
  }
}
