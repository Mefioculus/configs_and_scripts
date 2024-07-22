local M = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        highlight = {
            enable = true,
            custom_captures = {
                additional_vim_regex_highlighting = false,
            },
        },
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

return M
