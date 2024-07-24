return {
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
        opts = {},
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
        priority = 1000,
        opts = {},
    },
}
