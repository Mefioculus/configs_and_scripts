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
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

return M
