return {
        'nvim-neorg/neorg',
        lazy = false,
        version = '*',
        config = function()
            require('neorg').setup {
                load = {
                    ['core.defaults'] = {},
                    ['core.concealer'] = {
                        config = {
                            folds = true,
                            init_open_folds = 'never',
                        },
                    },
                    ['core.dirman'] = {
                        config = {
                            workspaces = {
                                notes = '~/notes',
                            },
                            default_workspace = 'notes',
                        },
                    },
                },
            }

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
            end,
        keys = {
            {"<leader>ind", "<cmd>Neorg index<cr>", desc = "Go to Index"},
        },
}
