return {
    {
        "tpope/vim-fugitive"
    },
    {
        'lewis6991/gitsigns.nvim',
    },
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {
            enabled = false,  -- Start disabled, toggle on demand
            message_template = " <author> • <date> • <summary>",
            date_format = "%r",
            virtual_text_column = 80,
        }
    }
}
