local M = {
    'nvim-neorg/neorg',
    lazy = false,
    version = "*",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                folds = True,
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    default_workspace = "notes",

                },
            },

        },
    },
    keys = {
        {"<leader>ind", "<cmd>Neorg index<cr>", desc = "Go to Index"},
    }
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

return M
