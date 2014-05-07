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

" Visual Search
" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
vmap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vmap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

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
set visualbell
set mouse=a
set fillchars+=vert:\│
set clipboard+=unnamed

" History
set history=10000

" Change cursor shape in iTerm two when changing to insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Write no backup / swap files
set nobackup
set noswapfile

" Syntax highlighting
set t_Co=256
syntax on
colorscheme t6d

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

" Use visual line scrolling
"nnoremap j gj
"nnoremap k gk

" GUI specific settings
if has("gui_running")
  " Turns on the tab bar always
  set showtabline=2

  " Remove tabbar
  set guioptions-=T

  " Remove scrollbar
  set guioptions-=r
  set guioptions-=l
  set guioptions-=L

  " Sets the font and size
  set guifont=Source\ Code\ Pro:h13
  set linespace=1

  " Sets the percent transparency
  " set transparency=10
  set background=light
  colorscheme hemisu
endif

"
" -- Auto commands --
"

" Add highlighting for Rspec keywords
autocmd BufNewFile,BufRead *_spec.rb syntax keyword rubyRspec describe context it xit specify it_should_behave_like before after around setup subject its shared_examples_for shared_context let let! to to_not not_to
autocmd BufNewFile,BufRead *_spec.rb highlight link rubyRspec Keyword

" Set foldmethod to indent for Ruby files to increase performance
autocmd Syntax ruby setlocal foldmethod=indent

" Remove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" Configure soft-wrapping for markdown documents
autocmd Syntax mkd set wrap linebreak nolist

" Disable folding in Markdown documents
autocmd Syntax mkd setlocal nofoldenable

" Use tabs in Go files
autocmd FileType go setlocal noexpandtab listchars=tab:\ \ ,trail:·,nbsp:·

" Auto format Go files before saving them
" autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Use // for comments in Go files
autocmd FileType go setlocal commentstring=//\ %s

"
" -- Key bindings --
"

" Motion command for selecting the contents of the next bracket pair
function! SelectContentsOfClosestBracketPair()
  let l:line = line('.')
  let l:column = col('.')
  let l:closest_left_bracket = 0
  let l:closest_right_bracket = 0
  let l:pattern = '\%' . l:line . 'l' . '[\[\](){}]'

  if search(l:pattern, 'Wc')
    let l:closest_right_bracket = col('.')
  endif

  if search(l:pattern, 'Wbc')
    let l:closest_left_bracket = col('.')
  endif

  if l:closest_left_bracket == 0 && l:closest_right_bracket == 0
    call cursor(l:line, l:column)
    return
  endif

  if l:closest_left_bracket > 0 && l:closest_right_bracket > 0
    if l:closest_left_bracket < l:closest_left_bracket
      call cursor(l:line, l:closest_left_bracket)
    else
      call cursor(l:line, l:closest_right_bracket)
    endif
  else
    if (l:closest_right_bracket - l:line) < (l:line - l:closest_left_bracket)
      call cursor(l:line, l:closest_right_bracket)
    else
      call cursor(l:line, l:closest_left_bracket)
    endif
  endif

  let l:bracket_char = getline(".")[col(".")-1]
  exec 'normal! vi' . l:bracket_char
endfunction
onoremap P :<C-U>call SelectContentsOfClosestBracketPair()<CR>

" Separator generation
function! GenerateSeparator(char)
  let l:width = max([0, 76 - col('.')])
  return repeat(a:char, l:width)
endfunction
iabbrev ---- <C-R>=GenerateSeparator('-')<CR>
iabbrev ==== <C-R>=GenerateSeparator('=')<CR>
iabbrev ++++ <C-R>=GenerateSeparator('+')<CR>
iabbrev **** <C-R>=GenerateSeparator('*')<CR>

" Set the mapleader
let mapleader=" "

" Toggle between relative and absolute line numbering
function! ToggleLineNumberingStyle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction
nnoremap <silent> <F2> :call ToggleLineNumberingStyle()<cr>

" Movement key bindings
" nnoremap <S-j> 10c
" nnoremap <S-k> 10k
" nnoremap <S-C-j> :m .+1<CR>
" nnoremap <S-C-k> :m .-2<CR>

" Reloading and Editing the vim configuration
nnoremap <silent> <leader>erc :edit ~/.vimrc<CR>
nnoremap <silent> <leader>src :source ~/.vimrc<CR>

" Edit working directory
nnoremap <silent> <leader>ewd :edit `pwd`<CR>

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
nnoremap <silent> <Leader>hs :noh<CR>

" Ctags
nnoremap <silent> <Leader>ct :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log -R *<CR><CR>

"
" -- Configuration options for plugins --
"

" Vroom
let g:vroom_zeus=1

" CtrlP
let g:ctrlp_user_command = 'ag %s -l --follow --nocolor -g ""'

