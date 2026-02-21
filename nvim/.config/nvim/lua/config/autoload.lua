-- Moder Lua auto-command for launching netrwPlugin which shipped with the nvim
-- local mygroup = vim.api.nvim_create_augroup("loading_netrwPlugin", {clear = true})
-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--   pattern = {"*"},
--   command  = ":silent! Explore",
--   group = mygroup
-- })

-- Treat *.ts.template files as TypeScript for LSP and Treesitter
vim.filetype.add({
    extension = {
        template = function(path)
            if path:match('%.ts%.template$') then
                return 'typescript'
            end
        end,
    },
})
