return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            pickers = {
                hidden = true,
               no_ignore = true,
            },
        },
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
            { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find Tags' },
        },
    },
}
