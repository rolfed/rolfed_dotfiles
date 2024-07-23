return {
    -- "christoomey/vim-tmux-navigator"
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
        require('smart-splits').setup({
            resize_mode = {
                silent = true,
                hooks = {
                    on_enter = function()
                        vim.notify('Entering resize mode')
                    end,
                    on_leave = function()
                        vim.notify('Exiting resize mode, bye')
                    end,
                },
            },
        })
    end
}
