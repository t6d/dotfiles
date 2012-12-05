"
" -- Settings --
"

" Generic settings
set nocompatible
filetype on
filetype plugin indent on

" Soft-tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Searching
set hlsearch
set incsearch

" Line numbering
set number

" Syntax highlighting
syntax on
colorscheme smyck

" Auto completion
set wildmode=longest,list,full
set wildmenu

" Pathogen
call pathogen#infect()

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
nnoremap <C-n> :call ToggleLineNumberingStyle()<cr>

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

" UltiSnips key-bindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Identify the highlighting group used at cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

