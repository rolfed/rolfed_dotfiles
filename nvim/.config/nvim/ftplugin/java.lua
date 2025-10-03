-- ftplugin/java.lua - Java-specific JDTLS configuration

local jdtls = require('jdtls')

-- Determine workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Find JDTLS installation
local mason_path = vim.fn.stdpath('data') .. '/mason/packages'
local jdtls_path = mason_path .. '/jdtls'
local lombok_path = jdtls_path .. '/lombok.jar'

-- Configuration
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', jdtls_path .. '/config_mac',
    '-data', workspace_dir,
  },

  root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.Assert.*",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
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
        useBlocks = true,
      },
      configuration = {
        runtimes = {}
      }
    }
  },

  init_options = {
    bundles = {}
  },

  on_attach = function(client, bufnr)
    -- Keybindings
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', '<leader>co', "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)
    vim.keymap.set('n', '<leader>cv', "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    vim.keymap.set('v', '<leader>cv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    vim.keymap.set('n', '<leader>cc', "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    vim.keymap.set('v', '<leader>cc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    vim.keymap.set('v', '<leader>cm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- Standard LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- Start JDTLS
jdtls.start_or_attach(config)
