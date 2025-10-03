-- Java Development with nvim-jdtls
-- Provides LSP, debugging, and testing for Java projects
return {
  "mfussenegger/nvim-jdtls",
  ft = "java", -- Lazy load only for Java files
  dependencies = {
    "mfussenegger/nvim-dap", -- Required for debugging
  },
}
