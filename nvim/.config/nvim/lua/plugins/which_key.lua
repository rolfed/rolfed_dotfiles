return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      -- Main leader key groups
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find/Format" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "LSP" },
      { "<leader>n", group = "Notes" },
      { "<leader>p", group = "Project" },
      { "<leader>r", group = "Refactor" },
      { "<leader>s", group = "Search/Split" },
      { "<leader>t", group = "Test/Toggle" },
      { "<leader>u", group = "UI/Undo" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Trouble/Diagnostics" },

      -- Git subgroups
      { "<leader>gh", group = "GitHub" },

      -- LSP subgroups
      { "<leader>la", group = "Actions" },
      { "<leader>lw", group = "Workspace" },

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
      { "<leader>wh", group = "Horizontal Split" },
      { "<leader>wv", group = "Vertical Split" },

      -- Bracket mappings
      { "]", group = "Next" },
      { "[", group = "Previous" },

      -- Goto mappings
      { "g", group = "Goto" },
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
