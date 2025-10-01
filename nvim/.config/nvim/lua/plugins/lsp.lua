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
          -- "gradle_ls",  -- Disabled: causes init_options errors, JDTLS handles Gradle
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
      -- Suppress lspconfig deprecation warning until v3.0.0 migration
      -- TODO: Migrate to vim.lsp.config when lspconfig v3.0.0 is released
      vim.g.lspconfig_deprecation_warnings = false

      -- Integrate LSP with autocomplete
      local capabilities = require('cmp_nvim_lsp')
          .default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lspconfig = require("lspconfig")

      -- Function to organize ts imports
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end


      local lua_ls = {};

      local typescriptFileTypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      }

      local tsserver = {
        enabled = false, --disable to priotitize vstls
        filetypes = typescriptFileTypes,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json", "deno.json", "deno.jsonc"),
        single_file_support = false,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize TS Imports"
          }
        }
      }

      local ts_ls = {
        enabled = false, --disable to priotitize vstls
        filetypes = typescriptFileTypes
      }

      local vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = typescriptFileTypes,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize TS Imports"
          }
        },
        settings = {
          complete_function_calls = true,
          vtsls = {

          },
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
        opts = function()
          return {
            tsserver = function()
              -- Disable tsserver
              return true
            end,
            ts_ls = function()
              -- Disable tsserver
              return true
            end,
          }
        end
      }


      local html = {
        fileTypes = {
          "html",
          "templ"
        },
        single_file_support = true,
      }

      local clangd = {
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

      local gopls = {}

      -- Gradle LS is disabled - JDTLS handles Gradle projects
      -- Uncomment if you need standalone Gradle LS
      -- local gradle_ls = {
      --   init_options = {
      --     settings = {
      --       gradleWrapperEnabled = true,
      --     }
      --   }
      -- }

      local servers = {
        clangd = clangd,
        gopls = {},
        -- gradle_ls = gradle_ls,  -- Disabled
        html = html,
        lua_ls = lua_ls,
        ts_ls = tsserver,
        vtsls = vtsls,
      }

      for server, opts in pairs(servers) do
        opts.capabilities = capabilities
        lspconfig[server].setup(opts)
      end

      -- Completely disable gradle_ls to prevent init_options errors
      -- Override the default config to make it completely inert
      lspconfig.gradle_ls.setup({
        enabled = false,
        autostart = false,
        single_file_support = false,
        filetypes = {},  -- Empty filetypes means it won't activate
        cmd = { "true" },  -- Dummy command that does nothing
        root_dir = function() return nil end,  -- Never find a root directory
      })

      -- Also stop any gradle_ls that tries to start
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          local clients = vim.lsp.get_active_clients({ name = "gradle_ls" })
          for _, client in ipairs(clients) do
            vim.lsp.stop_client(client.id, true)
          end
        end,
      })

      -- Java LSP is handled by nvim-java plugin, not manual jdtls setup
    end
  }
}
