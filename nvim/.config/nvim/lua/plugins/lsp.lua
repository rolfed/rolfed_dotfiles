return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
        require("mason-lspconfig").setup({
          -- List of servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#configuration
          ensure_installed = {
            "bashls",
            "black",
            "clangd",
            "denols",
            "lua_ls",
            "spellcheck",
            "ts_ls",
            "markdown-oxide"
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

        local lspconfig = require("lspconfig")

        local _lua_ls = {};

        local _ts_ls = {
          filetypes = {
            'typescript', -- Typescript files (.ts)
            'javascript', -- Javascript files (.js)
          },
          on_attach = on_attach,
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = true,
        }
        
        local _denols = {
          on_attach = on_attach,
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          single_file_support = true,
        }

        local _black = {}

        local _html = {
            fileTypes = {
              "html",
              "templ"
            },
            single_file_support = true,
            opts = function()
              local _capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities.textDocument.completion.completionItem.snippetSupport = true

              return {
                capabilities = _capabilities
              }
            end
        }

        local _clangd = {
           filetypes = {
              "c",
              "cpp",
           },
           opts = function()
              return {
                offsetEncoding = { "utf-8" },
                textDocument = {
                  completion = {
                    editNearCursor = true
                  }
                }
              }
           end
        }

        local _gopls = {}

        local _markdown_oxide = {
            filetypes = { "makrdown" },
        }

        local servers = {
          black = _black,
          clangd = _clangd,
          denols = _denols,
          gopls = {},
          gradle_ls = _gopls,
          html = _html, 
          java_language_server = {},
          lua_ls = _lua_ls,
          markdown_oxide = _markdown_oxide 
          ts_ls = _ts_ls,
        }

        for server, opts in pairs(servers) do
          opts.capabilities = capabilities
          lspconfig[server].setup(opts)
        end
    end
  }
}
