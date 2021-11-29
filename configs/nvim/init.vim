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

Plug 'itchyny/lightline.vim'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'sainnhe/gruvbox-material'
Plug 'neovim/nvim-lspconfig'
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
