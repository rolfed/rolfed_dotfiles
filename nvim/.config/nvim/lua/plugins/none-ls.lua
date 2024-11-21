return {
  --
  -- None LSP (null-ls) is a Neovim plugin designed to enhance the LSP
  -- ecosystem by enabling non-LSP sources to integrate with Neovim's
  -- LSP client. It simplifies the creation, sharing, and setup of
  -- LSP sources using Lua scripting. Additionally, null-ls aims to
  -- streamline the configuration of general-purpose language servers
  -- and improve performance by eliminating the need for external processes.
  -- List of formatters and linters:
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
  'nvimtools/none-ls.nvim',
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },
  opts = function(_, opts)
    local null_ls = require('null-ls')
    opts.sources = opts.sources or {}
    null_ls.setup({
      source = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.alejandra,

        require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
        require("none-ls.diagnostics.cpplint"),
      }
    })
  end
}
