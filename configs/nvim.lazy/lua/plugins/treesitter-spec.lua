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
        ensure_installed = {
            "bash",
            "c_sharp",
            "xml",
            "json",
            "html",
            "python",
            "rust",
            "markdown",
            "markdown-inline",
            "norg-meta",
            "norg",
            "regex",
            "toml",
            "yaml",
            "vim",
            "vimdoc",
            "diff",
        },
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

return M
