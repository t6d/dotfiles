" Soft-tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Auto completion
set wildmode=longest,list,full
set wildmenu

" Remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e
" Pathogen
call pathogen#infect()

" Vundle specific settings
set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'vim-ruby/vim-ruby'

" Syntax highlighting
syntax on
colorscheme smyck

" Line numbering
set number

function! ToggleLineNumberingStyle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call ToggleLineNumberingStyle()<cr>

nnoremap <S-j> 10j
nnoremap <S-k> 10k

