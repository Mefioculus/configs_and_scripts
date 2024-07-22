return {
    {
        'nvim-lualine/lualine.nvim',
        --lazy = false,
        --priority = 999,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
            theme = 'gruvbox-material',
            }
        },
    },
}
