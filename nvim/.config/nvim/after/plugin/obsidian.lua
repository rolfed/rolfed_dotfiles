vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { desc = "New note" })
vim.keymap.set('n', '<leader>nD', '<cmd>ObsidianDailies<cr>', { desc = "Daily notes" })
vim.keymap.set('n', '<leader>ns', '<cmd>ObsidianSearch<cr>', { desc = "Search notes" })
vim.keymap.set('n', '<leader>nw', '<cmd>ObsidianWorkspace<cr>', { desc = "Switch workspace" })

-- Function to check if work vault exists
local function get_workspaces()
  local workspaces = {
    {
      name = "Personal",
      path = "~/repos/vault/personal"
    }
  }

  -- Check if work vault exists before adding it
  local work_vault_path = vim.fn.expand("~/repos/vault/work")
  if vim.fn.isdirectory(work_vault_path) == 1 then
    table.insert(workspaces, 1, {
      name = "Work",
      path = "~/repos/vault/work"
    })
  end

  return workspaces
end

require("obsidian").setup({
  workspaces = get_workspaces(),
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "notes/dailies",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%B %-d, %Y",
    -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"]       = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    }
  },
})
