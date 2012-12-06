"
" -- Settings --
"

" Pathogen
call pathogen#infect()

" Help tags
helptags ~/.vim/bundle/ultisnips/doc
helptags ~/.vim/bundle/supertab/doc

" Generic settings
set nocompatible
filetype plugin indent on

" Soft-tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Searching
set hlsearch
set incsearch

" Lines
set linebreak
set number

" Syntax highlighting
syntax on
colorscheme smyck

" Folding
set foldmethod=syntax
set foldlevel=99

" Auto completion
set wildmode=longest,list,full
set wildmenu

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

" Toggle between relative and absolute line numbering
function! ToggleLineNumberingStyle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <S-D-l> :call ToggleLineNumberingStyle()<cr>

" Movement key bindings
" nnoremap <S-j> 10j
" nnoremap <S-k> 10k
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>

" Reload .vimrc
nnoremap <D-r> :source ~/.vimrc<CR>
nnoremap <D-R> :tabnew ~/.vimrc<CR>

" Indentation key-bindings
vmap <Tab> >gv
vmap <S-Tab> <gv

" Supertab key-bindings
" let g:SuperTabMappingForward = '<c-space>'
" let g:SuperTabMappingBackward = '<s-c-space>'

" Identify the highlighting group used at cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

