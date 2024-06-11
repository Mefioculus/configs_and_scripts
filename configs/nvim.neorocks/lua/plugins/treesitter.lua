require("nvim-treesitter.configs").setup({
    --ensure_installed = { "c_sharp" },
    highlight = {
        enable = true,
        custom_captures = {
            additional_vim_regex_highlighting = false,
        },
    },
    --parser_install_dir = "/usr/local/lib/nvim/parser"
})

--vim.opt.runtimepath:append("/usr/local/lib/nvim/parser");

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
