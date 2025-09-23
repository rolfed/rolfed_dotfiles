-- Java-specific settings and jdtls setup
local jdtls = require('jdtls')

-- Java-specific vim options
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.cmdheight = 2

-- Function to find root directory
local function get_jdtls_paths()
  local path = {}
  path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

  local jdtls_install = require('mason-registry').get_package('jdtls'):get_install_path()

  path.java_agent = jdtls_install .. '/lombok.jar'
  path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

  if vim.fn.has('mac') == 1 then
    path.platform_config = jdtls_install .. '/config_mac'
  elseif vim.fn.has('unix') == 1 then
    path.platform_config = jdtls_install .. '/config_linux'
  elseif vim.fn.has('win32') == 1 then
    path.platform_config = jdtls_install .. '/config_win'
  end

  path.bundles = {}

  -- java-debug
  local java_debug_install = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
  path.java_debug_bundle = vim.fn.glob(java_debug_install .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
  if path.java_debug_bundle ~= '' then
    table.insert(path.bundles, path.java_debug_bundle)
  end

  -- java-test
  local java_test_install = require('mason-registry').get_package('java-test'):get_install_path()
  local java_test_bundle = vim.fn.glob(java_test_install .. '/extension/server/*.jar', true)
  vim.list_extend(path.bundles, vim.split(java_test_bundle, '\n'))

  return path
end

-- Configuration
local function get_jdtls_config()
  local path = get_jdtls_paths()
  local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

  if vim.fn.has('mac') == 1 then
    JAVA_DAP_ACTIVE = true
  end

  local config = {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-javaagent:' .. path.java_agent,
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', path.launcher_jar,
      '-configuration', path.platform_config,
      '-data', data_dir,
    },
    root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
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
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    },
    init_options = {
      bundles = path.bundles,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }

  return config
end

-- Setup jdtls
jdtls.start_or_attach(get_jdtls_config())
