return {
    "chentoast/marks.nvim",
    config = function()
        require('marks').setup({
            set_next = "m,",
            next = "mn",
        })
    end
}
