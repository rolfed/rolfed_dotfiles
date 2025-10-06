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
        -- List of servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#configuration
        ensure_installed = {
          "bashls",
          "clangd",
          "denols",
          "lua_ls",
          "spellcheck",
          "tsserver",
          "ts_ls",
          "vtsls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
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

      -- Helper function to find root directory
      local function root_pattern(...)
        local patterns = {...}
        return function(fname)
          for _, pattern in ipairs(patterns) do
            local match = vim.fs.find(pattern, {
              upward = true,
              path = vim.fs.dirname(fname),
            })[1]
            if match then
              return vim.fs.dirname(match)
            end
          end
        end
      end

      -- Configure LSP servers using vim.lsp.config
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config.lua_ls = {}

      vim.lsp.config.ts_ls = {
        enabled = false, -- disable to prioritize vtsls
        filetypes = typescriptFileTypes,
      }

      vim.lsp.config.vtsls = {
        filetypes = typescriptFileTypes,
        cmd = { 'vtsls', '--stdio' },
        root_dir = root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
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
        root_dir = root_pattern('.git'),
        single_file_support = true,
      }

      vim.lsp.config.clangd = {
        filetypes = { "c", "cpp" },
        cmd = { 'clangd' },
        root_dir = root_pattern('compile_commands.json', '.git'),
      }

      vim.lsp.config.gopls = {
        cmd = { 'gopls' },
        root_dir = root_pattern('go.mod', 'go.work', '.git'),
      }

      vim.lsp.config.markdown_oxide = {
        cmd = { 'markdown-oxide' },
        filetypes = { 'markdown' },
        root_dir = root_pattern('.git', '.obsidian'),
      }

      vim.lsp.config.somesass_ls = {
        cmd = { 'some-sass-language-server', '--stdio' },
        filetypes = { 'scss', 'sass' },
        root_dir = root_pattern('.git'),
      }

      vim.lsp.config.bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_dir = root_pattern('.git'),
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
    end
  }
}
