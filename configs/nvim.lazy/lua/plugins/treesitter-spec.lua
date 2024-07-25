return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('nvim-treesitter.configs').setup {
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
                "norg",
                "regex",
                "toml",
                "yaml",
                "vim",
                "vimdoc",
                "diff",
            },
        }

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end,
}
