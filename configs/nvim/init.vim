" Настройка удобной табуляции
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

"Копирование табуляции с предыдущей строки
set autoindent

"Вставка табуляции на основании данных, чем закончилась текущая строка
set smartindent
" syntax=on

" Включаем подсветку строки, в которой мы в данный момент производим
" редактирование
set cursorline

"Далее, настроим более удобный поиск по файлу. Для начала включим поиск в
"процессе набора
set incsearch

"Для того, чтобы в Markdown не скрывались служебные символы, поставлю так же
"следующую настройку
" set conceallevel=0 " К сожалению, данная настойка не работает из-за
" конфликта с плагином IndentLine (он при каждом запуске выставляет значение
" на 2)
" Проблема была решена добавлением соответствующей настройки в настройки
" самого плагина

"Далее включим подсветку всех результатов поиска
set hlsearch

filetype plugin indent on
" Данная настройка включает определения типа файлов, загрузку соответствующих
" ем уплагинов и файлов отступов

set encoding=utf-8
set nocompatible
syntax enable

" Настройка сворачивание текста в кодовой базе через синтаксис
set foldenable
set foldmethod=syntax
" Настройка сворачивания через скобочки
"set foldnestmax=3
"set foldlevel=2

" Сворачивание по фигурным ковычкам
" Folding : http://vim.wikia.com/wiki/Syntax-based_folding, see comment by
" Ostrygen
"au FileType cs set omnifunc=syntaxcomplete#Complete
"au FileType cs set foldmethod=marker
"au FileType cs set foldmarker={,}
"au FileType cs set foldlevelstart=2


" Добавление строк в окно vim
set number relativenumber

"Настройка курсора
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"





"ВСЕ НАСТРОЙКИ, ОТНОСЯЩИЕСЯ К НАСТРОЙКЕ ПЛАГИНОВ

" Далее приступаем к скачиванию менеджера пакетов. Делается это с github,
" причем производится проверкой при каждом включении программы.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Последующие настройки необходимы для настройки самого менеджера пакетов
call plug#begin('~/.vim/bundle')


" В данном месте нужно будет перечислять плагины, которые пакетному менеджеру
" необходимо будет устанавливать
Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'vim-airline/vim-airline' "Отключил плагин, потому что пользуюсь
"ligthline
Plug 'valloric/youcompleteme' "Отключил плагин, так как не работал с Csharp
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/csharp.vim'
Plug 'yggdroot/indentline'
Plug 'vifm/vifm.vim'
"Plug 'Omnisharp/omnisharp-vim'
"Plug 'plasticboy/vim-markdown' - плагин странно работал с markdown файлами
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-surround' " для автоматического обертывания слов тэками, кавычками и скобками

"Плагины для web разработки
Plug 'alvan/vim-closetag' "Automatic tab closing
Plug 'mattn/emmet-vim' "Emmet, fast HTML inserting


call plug#end()

"==================== OmniSharp settings start ====================

" OmniSharp won't work without this setting
"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

" Use Roslyn and also better performance that HTTP
"let g:OmniSharp_server_stdio = 1
"let g:omnicomplete_fetch_full_documentation = 1

" Settings for using Omnisharp with mono
"let g:OmniSharp_server_use_mono = 1

"let g:OmniSharp_timeout = 30

" this will make it so any subsequent C# files that you open using the same
" solution and you aren't prompted again
"let g:OmniSharp_autoselect_existing_sln = 1

"let g:OmniSharp_popup_option = {
"\ 'highlight': 'Normal',
"\ 'padding': [1],
"\ 'border': [1]
"\}

"==================== OmniSharp settings ends =====================


"==================== closetag settings start ====================
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_regions = {
    \ 'typescript.tsx' : 'jsxRegion,tsxRegion',
    \ 'javascript.jsx' : 'jsxRegion',
    \}
"==================== closetag settings end ====================

"==================== Indent line settings start ====================
" Данный плагин при каждом запуске вносит изменения в параметр
" conceallevel, который влияет на автоскрывание символов в определенных
" файлах, что крайне неудобно работает с некоторыми форматами (к примеру,
" с форматом markdown). Для того, чтобы это отключить, я использую
" следующую настройку

let g:indentLine_fileTypeExclude = ['markdown'] "Для файлов markdown плагин работать не будет

" Второй вариант отключения функции
" leg g:indentLine_setConceal = 0 " Данная настрока отключит эту опцию во всем
" плагине, что может не правильно сработать

"==================== Indent line settings ends ====================


"==================== EasyMotion settings starts ==================
" Настройка клавиши ; на поик одного симпола по вмему видимому документу
" (и назад и вперед)

map <Leader>; <Plug>(easymotion-s)

"==================== EasyMotion settings ends ====================




" Настройки, касающиеся плагина airline
"let g:airline_powerline_fonts = 1 "Включение поддержки powerline шрифтов
"let g:airline#extensions#keymap#enabled = 0 "Не показывать текущий маппинг
"let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
"let g:Powerline_symbols='unicode'
"let g:airline#extensions#xkblayout#enabled = 0

" set guifont=Fira\ Mono\ for\ Powerline:h16

"==================== lightline settings ends ====================
set laststatus=2
"Настройка цветовой схемы
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \}
"==================== lightline settings ends ====================


" Код для настройки срабатывания предложения автокомплита автоматически по
" нажатию любой клавиши

"function! OpenCompletion()
"    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
"        call feedkeys("\<C-X>\<C-O>", "n")
"    endif
"endfunction

"autocmd InsertCharPre * call OpenCompletion()

"set completeopt+=menuone,noselect,noinsert

" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.


"==================== monokaitheme settings starts ====================
" Установка цветовой схемы
colorscheme sublimemonokai
"==================== monokaitheme settings ends ====================


runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

