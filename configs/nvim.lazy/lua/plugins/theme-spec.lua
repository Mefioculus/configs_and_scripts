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
    {
        'kdheepak/monochrome.nvim',
        name = 'monochrome',
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
        'wnkz/monoglow.nvim',
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
        'slugbyte/lackluster.nvim',
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
        'aliqyan-21/darkvoid.nvim',
        lazy = true,
        priority = 1000,
        opts = {},
    },
}
