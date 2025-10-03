-- ftplugin/java.lua
-- Java-specific configuration using nvim-jdtls
-- Optimized for: Gradle, Spring Boot, JUnit 5, Spock, multi-project workspaces

local jdtls = require('jdtls')

-- Determine OS-specific configuration directory
local os_config = 'config_mac'
if vim.fn.has('linux') == 1 then
  os_config = 'config_linux'
elseif vim.fn.has('win32') == 1 then
  os_config = 'config_win'
end

-- Paths
local mason_path = vim.fn.stdpath('data') .. '/mason/packages'
local jdtls_path = mason_path .. '/jdtls'
local lombok_path = jdtls_path .. '/lombok.jar'

-- Workspace directory: separate workspace per project
-- This prevents projects from interfering with each other
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Find java-test and java-debug-adapter bundles installed by Mason
local function get_bundles()
  local bundles = {}

  -- Java Debug Adapter
  local java_debug_path = mason_path .. '/java-debug-adapter/extension/server'
  if vim.fn.isdirectory(java_debug_path) == 1 then
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. '/com.microsoft.java.debug.plugin-*.jar'), '\n'))
  end

  -- Java Test Runner
  local java_test_path = mason_path .. '/java-test/extension/server'
  if vim.fn.isdirectory(java_test_path) == 1 then
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. '/*.jar'), '\n'))
  end

  return bundles
end

-- JDTLS command configuration
local cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx2g', -- Increased memory for multi-module projects
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

  -- Lombok support (common in Spring Boot projects)
  '-javaagent:' .. lombok_path,

  -- JDTLS JAR
  '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

  -- Platform-specific configuration
  '-configuration', jdtls_path .. '/' .. os_config,

  -- Workspace directory
  '-data', workspace_dir,
}

-- Root directory detection (supports Gradle multi-module projects)
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'settings.gradle' }
local root_dir = jdtls.setup.find_root(root_markers)

-- Extended client capabilities (for nvim-cmp integration)
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- JDTLS settings
local settings = {
  java = {
    -- Eclipse settings
    eclipse = {
      downloadSources = true,
    },
    -- Code generation settings
    configuration = {
      updateBuildConfiguration = "automatic",
      -- Detect multiple Java runtimes (useful for Spring Boot projects)
      runtimes = {
        -- Add your JDK paths here if needed, e.g.:
        -- {
        --   name = "JavaSE-17",
        --   path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
        --   default = true,
        -- },
      },
    },
    -- Maven settings
    maven = {
      downloadSources = true,
    },
    -- Implementation code lens (shows implementing classes)
    implementationsCodeLens = {
      enabled = true,
    },
    -- References code lens (shows references count)
    referencesCodeLens = {
      enabled = true,
    },
    -- Inlay hints for parameter names
    inlayHints = {
      parameterNames = {
        enabled = "all",
      },
    },
    -- Format settings (compatible with Spring Boot conventions)
    format = {
      enabled = true,
      settings = {
        url = vim.fn.stdpath("config") .. "/lang-config/java/intellij-java-google-style.xml",
        profile = "GoogleStyle",
      },
    },
    -- Signature help
    signatureHelp = { enabled = true },
    -- Content provider preferences
    contentProvider = { preferred = 'fernflower' },
    -- Completion settings
    completion = {
      favoriteStaticMembers = {
        "org.junit.jupiter.api.Assertions.*",
        "org.assertj.core.api.Assertions.*",
        "org.mockito.Mockito.*",
        "org.mockito.ArgumentMatchers.*",
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
      importOrder = {
        "java",
        "javax",
        "org",
        "com",
      },
    },
    -- Source settings
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    -- Code generation templates
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
  },
}

-- LSP on_attach function (keybindings and capabilities)
local on_attach = function(client, bufnr)
  -- Regular LSP keybindings are handled by after/plugin/lsp.lua via LspAttach autocmd

  -- Java-specific keybindings
  local opts = { buffer = bufnr, silent = true }

  -- Code organization
  vim.keymap.set('n', '<leader>jo', "<Cmd>lua require('jdtls').organize_imports()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Organize imports" }))

  -- Refactoring
  vim.keymap.set('n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Extract variable" }))
  vim.keymap.set('v', '<leader>jv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Extract variable" }))

  vim.keymap.set('n', '<leader>jc', "<Cmd>lua require('jdtls').extract_constant()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Extract constant" }))
  vim.keymap.set('v', '<leader>jc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Extract constant" }))

  vim.keymap.set('v', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Extract method" }))

  -- Test commands (JUnit 5 + Spock support)
  vim.keymap.set('n', '<leader>jt', "<Cmd>lua require('jdtls').test_class()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Test class" }))
  vim.keymap.set('n', '<leader>jT', "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Test method" }))

  -- Debug test
  vim.keymap.set('n', '<leader>jdt', "<Cmd>lua require('jdtls').test_class({ config = { name = 'Debug Test' }})<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Debug test class" }))
  vim.keymap.set('n', '<leader>jdT', "<Cmd>lua require('jdtls').test_nearest_method({ config = { name = 'Debug Test' }})<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Debug test method" }))

  -- Spring Boot specific
  vim.keymap.set('n', '<leader>jb', "<Cmd>lua require('jdtls').build_projects()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Build project" }))
  vim.keymap.set('n', '<leader>ju', "<Cmd>lua require('jdtls').update_project_config()<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Update project config" }))

  -- Gradle specific commands
  vim.keymap.set('n', '<leader>jg', "<Cmd>lua require('jdtls').compile('incremental')<CR>",
    vim.tbl_extend('force', opts, { desc = "Java: Gradle compile" }))

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true)
  end
end

-- Main JDTLS configuration
local config = {
  cmd = cmd,
  root_dir = root_dir,
  settings = settings,
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  -- Extended capabilities for JDTLS
  init_options = {
    bundles = get_bundles(),
    extendedClientCapabilities = extendedClientCapabilities,
  },

  -- Enable DAP (debugger) - will be configured in Phase 2
  on_init = function(client)
    client.notify('workspace/didChangeConfiguration', { settings = settings })
  end,
}

-- Start or attach to JDTLS
jdtls.start_or_attach(config)

-- Auto-import on save (optional, can be commented out if too aggressive)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.java",
  callback = function()
    local _, _ = pcall(vim.lsp.buf.code_action, {
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
  end,
})
