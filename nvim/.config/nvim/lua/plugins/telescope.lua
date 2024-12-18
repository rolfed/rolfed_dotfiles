return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      -- version = '^1.0.0',
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        fzf = {
          fuzzy = true,               -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case",   -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
            -- even more opts
          }
        }
      }
    }

    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('notify')
    require('telescope').load_extension('live_grep_args')
  end
}
