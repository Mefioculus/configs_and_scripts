"Настройка удобной табуляции
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

"Настраивание автоматических отступов
set autoindent
set smartindent

" Производим настройку поиска
set incsearch
set hlsearch

filetype plugin indent on

set encoding=utf-8
set nocompatible
syntax enable

" Подключаем сворачивание блоков кода по синтаксису
set foldenable
set foldmethod=syntax

" Устанавливаем относительную нумерацию строк
set number relativenumber

"Наcтраиваем курсор
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" Подключаем плагины
call plug#begin('~/.nvim/bundle')

" Для установки cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-treesitter/nvim-treesitter', { 'do' : 'TSUpdate' }

Plug 'itchyny/lightline.vim'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

" Настройка lsp клиента
" Включаем lua для подключения lsp
lua << EOF
require'lspconfig'.csharp_ls.setup{}
require('gitsigns').setup()
EOF

" Настройка плагина cmp
set completeopt=menu,menuone,noselect

lua << EOF
-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.scroll_docs(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true}),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp'},
        { name = 'vsnip' },
        }, {
        { name = 'buffer' },
        })
    })
    
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
    
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['csharp_ls'].setup {
    capabilities = capabilities
}

EOF

" Настройка плагина nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        custom_captures = {
            --Highlight the @foo.bar capture group with the "Inentifier" highlight group
            --["foo.bar"] = "Identifier",
            additional_vim_regex_highlighting = false,
        },
    }
}
EOF


" Настройка плагина Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" Устанавливаем цветовую схему
" colorscheme sublimemonokai

if has('termguicolors')
    set termguicolors
endif
set background=dark
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material

let g:lightline = {'colorscheme' : 'gruvbox_material'}
