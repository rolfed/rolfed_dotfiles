return {
  {
    -- Mason install all our lsps
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    -- Brigdes the gap between mason and lsp
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()

      require("mason-lspconfig").setup({
        -- List of servers: https://github.com/mason-org/mason-lspconfig.nvim?tab=readme-ov-file#configuration
        -- dartls and gopls are absent on purpose. The Dart analysis server
        -- ships with the Dart SDK and has no Mason package, and Mason builds
        -- gopls with `go install`, which needs a Go toolchain on PATH.
        ensure_installed = {
          "bashls",
          "clangd",
          "denols",
          "html",
          "lua_ls",
          "markdown_oxide",
          "somesass_ls",
          "ts_ls",
          "vtsls",
        },
        -- vtsls owns TypeScript. ts_ls and denols stay installed but must not
        -- auto-attach, or all three race for the same buffer.
        automatic_enable = {
          exclude = { "denols", "ts_ls" },
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    -- Not lazy-loaded: vim.lsp.enable() only adopts already-open buffers once
    -- v:vim_did_enter is 1, so loading this on BufReadPost leaves a file passed
    -- on the command line with no client.
    lazy = false,
    config = function()
      -- Integrate LSP with autocomplete
      local capabilities = require('cmp_nvim_lsp')
          .default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Function to organize ts imports
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end

      local typescriptFileTypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      }

      -- Configure LSP servers using vim.lsp.config
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config.lua_ls = {}

      vim.lsp.config.vtsls = {
        filetypes = typescriptFileTypes,
        cmd = { 'vtsls', '--stdio' },
        root_markers = { { 'package.json', 'tsconfig.json', 'jsconfig.json' }, '.git' },
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize TS Imports"
          }
        },
        settings = {
          complete_function_calls = true,
          vtsls = {},
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            }
          },
        },
      }

      vim.lsp.config.html = {
        filetypes = { "html", "templ" },
        cmd = { 'vscode-html-language-server', '--stdio' },
        root_markers = { '.git' },
      }

      vim.lsp.config.clangd = {
        filetypes = { "c", "cpp" },
        cmd = { 'clangd' },
        root_markers = { 'compile_commands.json', '.git' },
      }

      vim.lsp.config.gopls = {
        cmd = { 'gopls' },
        root_markers = { { 'go.mod', 'go.work' }, '.git' },
      }

      vim.lsp.config.markdown_oxide = {
        cmd = { 'markdown-oxide' },
        filetypes = { 'markdown' },
        root_markers = { '.obsidian', '.git' },
      }

      vim.lsp.config.somesass_ls = {
        cmd = { 'some-sass-language-server', '--stdio' },
        filetypes = { 'scss', 'sass' },
        root_markers = { '.git' },
      }

      vim.lsp.config.bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_markers = { '.git' },
      }

      -- Ships with the Dart SDK rather than Mason, so `dart` must be on PATH.
      vim.lsp.config.dartls = {
        cmd = { 'dart', 'language-server', '--protocol=lsp' },
        filetypes = { 'dart' },
        root_markers = { 'pubspec.yaml', '.git' },
      }

      -- Enable LSP servers
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('vtsls')
      vim.lsp.enable('html')
      vim.lsp.enable('clangd')
      vim.lsp.enable('gopls')
      vim.lsp.enable('markdown_oxide')
      vim.lsp.enable('somesass_ls')
      vim.lsp.enable('bashls')
      vim.lsp.enable('dartls')
    end
  }
}
