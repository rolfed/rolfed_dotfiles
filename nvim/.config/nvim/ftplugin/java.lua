-- Java-specific settings
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.cmdheight = 2

local jdtls = require('jdtls')

-- Find project root
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Get Mason paths for Java bundles
local mason_path = vim.fn.stdpath('data') .. '/mason/packages'
local bundles = {}

-- Add java-debug-adapter bundle
local java_debug_path = mason_path .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
local java_debug_bundle = vim.fn.glob(java_debug_path, true)
if java_debug_bundle ~= '' then
  table.insert(bundles, java_debug_bundle)
end

-- Add java-test bundle
local java_test_path = mason_path .. '/java-test/extension/server/com.microsoft.java.test.plugin-*.jar'
local java_test_bundle = vim.fn.glob(java_test_path, true)
if java_test_bundle ~= '' then
  table.insert(bundles, java_test_bundle)
end

local config = {
  cmd = {
    'jdtls',
    '-data', workspace_dir
  },
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'build.gradle'}, { upward = true })[1]),
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-21",
            path = vim.fn.getenv("JAVA_HOME"),
          }
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*"
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      },
      useBlocks = true,
    },
  },
  init_options = {
    bundles = bundles
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Setup DAP
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end,
}

jdtls.start_or_attach(config)
