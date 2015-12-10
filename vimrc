" Use vim, not vi, settings!
set nocompatible

" Setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'andrewradev/splitjoin.vim'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'edsono/vim-matchit'
Plugin 'ervandew/supertab'
Plugin 'exu/pgsql.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'guns/vim-clojure-static'
Plugin 'honza/vim-snippets'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'kokakolako/vim-hemisu-airline'
Plugin 'mattn/emmet-vim'
Plugin 'mxw/vim-jsx'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'skalnik/vim-vroom'
Plugin 't6d/vimux'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-salve'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/paredit.vim'

if !empty($GOPATH)
  Plugin 'fatih/vim-go'
endif
call vundle#end()

" Generic settings
filetype plugin indent on

" Macros
runtime macros/matchit.vim " required by textobj-rubyblock

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
  set guifont=Source\ Code\ Pro\ for\ Powerline:h13
  set linespace=2
  set fillchars&
  set fillchars-=vert:\|

  " Sets the percent transparency
  " set transparency=10
  set background=light
  colorscheme hemisu
endif

"
" -- Auto commands --
"

" Add highlighting for Rspec keywords
autocmd BufNewFile,BufRead *_spec.rb syntax keyword rubyRspec describe context it xit specify it_should_behave_like before after around setup subject its shared_examples_for shared_context let let! to to_not not_to expect
autocmd BufNewFile,BufRead *_spec.rb highlight link rubyRspec Keyword

" Add highlighting for additional Minitest Assertions
autocmd BufNewFile,BufRead *_test.rb syntax keyword minitestAssertion assert assert_empty assert_equal assert_in_delta assert_in_epsilon assert_includes assert_instance_of assert_kind_of assert_match assert_nil assert_operator assert_output assert_predicate assert_raises assert_respond_to assert_same assert_send assert_silent assert_throws refute refute_empty refute_equal refute_in_delta refute_in_epsilon refute_includes refute_instance_of refute_kind_of refute_match refute_nil refute_operator refute_predicate refute_respond_to refute_same
autocmd BufNewFile,BufRead *_test.rb highlight link minitestAssertion Keyword

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
nnoremap <silent> <leader>se :UltiSnipsEdit<cr>

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

" Section jumping in TeX Documents
autocmd Syntax rnoweb,tex noremap <buffer> <silent> ]] :<c-u>call TexJump2Section( v:count1, '' )<CR>
autocmd Syntax rnoweb,tex noremap <buffer> <silent> [[ :<c-u>call TexJump2Section( v:count1, 'b' )<CR>
function! TexJump2Section( cnt, dir )
  let i = 0
  let pat = '^\s*\\\(part\|chapter\|\(sub\)*section\|paragraph\)\>\|\%$\|\%^'
  let flags = 'W' . a:dir
  while i < a:cnt && search( pat, flags ) > 0
    let i = i+1
  endwhile
  " Store the pattern in the search register
  " let @/ = pat
endfunction

" http://stackoverflow.com/a/7321131/114490
function! WipeBuffers()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! WipeBuffers :call WipeBuffers()

"
" -- Configuration options for plugins --
"

" Vroom
let g:vroom_zeus=1
let g:vroom_use_vimux=1
let g:vroom_test_unit_command='testrb'

" CtrlP
if executable("ag")
  let g:ctrlp_user_command = 'ag %s -l --follow --nocolor -g ""'
endif
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Airline
let g:airline_powerline_fonts = 1
if has("gui_running")
  let g:airline_theme='light'
else
  let g:airline_theme='powerlineish'
endif

" Markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'html', 'javascript', 'js=javascript', 'json=javascript', 'python', 'ruby', 'sass', 'xml']

" UltiSnips
let g:UltiSnipsEditSplit = "vertical"

" Vimux
command! VimuxVSplit :call VimuxOpenRunnerWithOptions(50, 'h')
command! -nargs=* VimuxRunCommandInVSplit :call VimuxOpenRunnerWithOptions(50, 'h') | call VimuxRunCommand(<args>)

function! VimuxOpenRunnerWithOptions(height, orientation)
  " Cache Variables
  if exists('g:VimuxHeight')
    let default_height = g:VimuxHeight
  endif

  if exists('g:VimuxOrientation')
    let default_orientation = g:VimuxOrientation
  endif

  let g:VimuxHeight = a:height
  let g:VimuxOrientation = a:orientation
  call VimuxOpenRunner()

  " Reset Variables
  if exists('default_height')
    let g:VimuxHeight = default_height
  else
    unlet g:VimuxHeight
  endif

  if exists('default_orientation')
    let g:VimuxOrientation = default_orientation
  else
    unlet g:VimuxOrientation
  endif
endfunction

function! VimuxPasteSelection()
  if !exists("g:VimuxRunnerIndex")
    call VimuxOpenRunner()
  end
  call VimuxSendText(substitute(@v, "\n\\\%$", "", "+"))
  call VimuxSendKeys("Enter")
endfunction

vmap <silent> <Leader>V "vy :call VimuxPasteSelection()<CR>
vmap <silent> <Leader>v "vy :call VimuxPasteSelection()<CR>
nmap <silent> <Leader>v :y v \| call VimuxPasteSelection()<CR>
nmap <silent> <Leader>V :%y v \| call VimuxPasteSelection()<CR>

function! SyntaxHighLightingForRegion(filetype, start, end, matchgroup) abort
  let regionIdentifier='embedded'.toupper(a:filetype)
  let group='textGroup'.toupper(a:filetype)
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  let command='syntax region '.regionIdentifier.' matchgroup='.a:matchgroup.' start='.a:start.' end='.a:end.' contains=@'.group
  execute command
endfunction

autocmd Syntax ruby call SyntaxHighLightingForRegion('eruby', '/\v\<\<-?ERB/', '/\v\s*ERB/', "SpecialComment")
