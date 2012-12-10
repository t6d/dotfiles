"
" -- Settings --
"

" Use vim, not vi, settings!
set nocompatible

" Pathogen
" filetype off will force reloading after pathogen loaded
filetype off
call pathogen#infect()
call pathogen#helptags()

" Macros
runtime macros/matchit.vim " required by textobj-rubyblock

" Generic settings
filetype plugin indent on

" Cmdline + Statusline
set cmdheight=1
set laststatus=2
set statusline=%f     " Path to the file
set statusline+=\     " Label
set statusline+=%y    " Filetype of the file
set statusline+=%=    " Switch to the right side
set statusline+=%l    " Current line
set statusline+=/     " Separator
set statusline+=%L    " Total lines

" Indentation settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set backspace=indent,eol,start
set autoindent
set copyindent
set smarttab

" Searching
set smartcase
set hlsearch
set incsearch
set gdefault

" Scrolling
nnoremap <C-E> 3<C-E>
nnoremap <C-Y> 3<C-Y>

" Editor settings
set linebreak
set number
set relativenumber
set termencoding=utf-8
set encoding=utf-8
set lazyredraw

" Write no backup / swap files
set nobackup
set noswapfile

" Syntax highlighting
syntax on
colorscheme smyck

" Invisible characters
set list
set listchars=tab:▸\ ,trail:·,nbsp:·

" Folding
set foldmethod=syntax
set foldlevel=99

" Auto completion
set wildmode=longest,list,full
set wildmenu

" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" GUI specific settings
if has("gui_running")
  " Turns on the tab bar always
  set showtabline=2

  " Window size
  set columns=80
  set lines=40

  " Remove tabbar
  set guioptions-=T

  " Remove scrollbar
  set guioptions-=r
  set guioptions-=l
  set guioptions-=L

  " Sets the font and size
  set guifont=Source\ Code\ Pro:h13
  set linespace=2

  " Sets the percent transparency
  " set transparency=10
endif

"
" -- Auto commands --
"

" Remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

"
" -- Key bindings --
"

" Map leader to ö
let mapleader='ö'

" Toggle between relative and absolute line numbering
function! ToggleLineNumberingStyle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <F2> :call ToggleLineNumberingStyle()<cr>

" Movement key bindings
" nnoremap <S-j> 10c
" nnoremap <S-k> 10k
nnoremap <S-C-j> :m .+1<CR>
nnoremap <S-C-k> :m .-2<CR>

" Faster switching between normal and insert mode
inoremap <C-CR> <Esc>
nnoremap <C-CR> a

" Reloading and Editing the vim configuration
nnoremap <silent> <leader>erc :edit ~/.vimrc<CR>
nnoremap <silent> <leader>src :source ~/.vimrc<CR>

" Editing ultisnips
nnoremap <silent> <leader>se :call UltiSnipsEdit()<cr>

" Indentation key-bindings
vmap <Tab> >gv
vmap <S-Tab> <gv

" Supertab key-bindings
" let g:SuperTabMappingForward = '<c-space>'
" let g:SuperTabMappingBackward = '<s-c-space>'

" Identify the highlighting group used at cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Toggle search highlighting
nnoremap <silent> <leader>hs :set hlsearch!<CR>

" Expand editor window
nnoremap <silent> <leader>rs :set columns=120 lines=60<CR>

