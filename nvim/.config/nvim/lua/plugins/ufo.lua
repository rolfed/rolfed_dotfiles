return {
    'kevinhwang91/nvim-ufo',
    event = { "BufEnter" },
    dependencies = {
        "kevinhwang91/promise-async",
    },
    config = function()
        require('ufo').setup({
            -- @diagnostics disable: unused-local
            provider_selector = function(_bufnr, _filetype, _buftype)
                return { "treesitter", "indent" }
            end
        })
    end
}
