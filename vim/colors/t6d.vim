set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "t6d"

hi clear Normal
hi clear LineNr
hi clear CursorLine
hi clear CursorLineNr
hi clear StatusLine
hi clear StatusLineNC
hi clear TabLineFill
hi clear TabLine
hi clear TabLineSel
hi clear VertSplit
hi clear Search
hi clear IncSearch
hi clear NonText
hi clear SpecialKey
hi clear MatchParen

hi Normal       guibg=#000000   guifg=#ffffff
hi LineNr       ctermfg=235     guifg=#262626
hi CursorLine   ctermbg=233     guibg=#121212
hi CursorLineNr ctermfg=214     guifg=#ffaf00
hi StatusLine   ctermfg=255     ctermbg=235   guifg=#ffffff guibg=#262626
hi StatusLineNC ctermfg=244     ctermbg=233   guifg=#808080 guibg=#121212
hi TabLineFill  ctermbg=233
hi TabLine      ctermfg=240     ctermbg=233
hi TabLineSel   ctermfg=255     ctermbg=235
hi VertSplit    ctermfg=235     guifg=#262626
hi Search       cterm=underline gui=underline
hi IncSearch    cterm=underline gui=underline
hi NonText      ctermfg=235
hi SpecialKey   ctermfg=235
hi MatchParen   ctermfg=214 guifg=#ffaf00

" hi ColumnMargin
" hi Error
" hi ErrorMsg
" hi Folded
" hi FoldColumn
" hi ModeMsg
" hi SpellBad
" hi SpellCap
" hi SpellRare
" hi SpellLocal
" hi Visual
" hi MatchParen
" hi CursorColumn
" hi Title

" ----------------------------------------------------------------------------
" PMenu Highlighting
" ----------------------------------------------------------------------------

hi clear Pmenu
hi clear PmenuSel
hi clear PmenuSbar

hi PmenuSbar  ctermfg=233 ctermbg=233 guifg=#121212 guibg=#121212
hi PmenuThumb ctermfg=235 ctermbg=235 guifg=#262626 guibg=#262626

hi link Pmenu    StatusLineNC
hi link PmenuSel StatusLine

" ----------------------------------------------------------------------------
" CtrlP Highlighting
" ----------------------------------------------------------------------------

hi CtrlPMode1 ctermfg=214 ctermbg=235 guifg=#ffaf00 guibg=#808080

hi link CtrlPLinePre LineNr
hi link CtrlPMatch   MatchParen
hi link CtrlPMode2   StatusLine

" ----------------------------------------------------------------------------
" Diff Highlighting
" ----------------------------------------------------------------------------

hi clear DiffFile
hi clear DiffLine
hi clear DiffAdd
hi clear DiffChange
hi clear DiffDelete

hi DiffFile   ctermfg=244 guifg=#808080
hi DiffLine   ctermfg=255 guifg=#ffffff cterm=underline gui=underline
hi DiffAdd    ctermfg=34  guifg=#00af00
hi DiffChange ctermfg=214 guifg=#ffaf00
hi DiffDelete ctermfg=196 guifg=#ff0000

hi link DiffNewFile DiffFile
hi link DiffAdded   DiffAdd
hi link DiffRemoved DiffDelete

" ----------------------------------------------------------------------------
" Syntax Highlighting
" ----------------------------------------------------------------------------

hi Comment       ctermfg=240 guifg=#585858
hi Type          ctermfg=214 guifg=#ffaf00
hi Identifier    ctermfg=39  guifg=#00afff
hi Keyword       ctermfg=196 guifg=#ff0000
hi Statement     ctermfg=196 guifg=#ff0000
hi PreProc       ctermfg=43  guifg=#00d7af
hi Symbol        ctermfg=202 guifg=#ff5f00
hi String        ctermfg=112 guifg=#87d700
hi Interpolation ctermfg=190 guifg=#d7ff00
hi Attribute     ctermfg=202 guifg=#ff5f00
hi Tag           ctermfg=214 guifg=#ffaf00
hi Special       ctermfg=255 guifg=#ffffff

hi Underlined cterm=underline ctermfg=none   ctermbg=none
hi Directory  ctermfg=39      guifg=#00afff

hi link Method Type
hi link Function Method
hi link Structure Type
hi link Constant Type
hi link Number Symbol
hi link Macro Keyword

" ----------------------------------------------------------------------------
" JavaScript Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link javaScriptFunction Keyword
hi link javaScriptThis Keyword
hi link javaScriptFuncName Normal
hi link javaScriptLabel Type

" ----------------------------------------------------------------------------
" Vim Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link vimHiAttrib Symbol

" ----------------------------------------------------------------------------
" Ruby Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link rubyBlockParameter Normal
hi link rubyDefine Keyword
hi link rubyBoolean Keyword
hi link rubyPseudoVariable Keyword
hi link rubySymbol Symbol
hi link rubyFunction Method
hi link rubyInterpolation Interpolation
hi link rubyAttribute Macro
hi link rubyInclude Macro
hi link rubyExtend Macro

hi link rubyRailsARMethod Macro
hi link rubyRailsARClassMethod Macro
hi link rubyRailsARAssociationMethod Macro
hi link rubyRailsARCallbackMethod Macro
hi link rubyRailsARValidationMethod Macro
hi link rubyRailsTestMethod Macro
" hi link rubyBeginend          Keyword
" hi link rubyClass             Keyword
" hi link rubyModule            Keyword
" hi link rubyKeyword           Keyword
" hi link rubyOperator          Method
" hi link rubyIdentifier        Keyword
" hi link rubyClassVariable     Symbol
" hi link rubyInstanceVariable  Constant
" hi link rubyGlobalVariable    Constant
" hi link rubyClassVariable     Method
" hi link rubyConstant          Constant
" hi link rubySymbol            Symbol
" hi link rubyFunction          Constant
" hi link rubyControl           Keyword
" hi link rubyConditional       Keyword
" hi link rubyInterpolation     Interpolation
" hi link rubyInterpolationDelimiter    Interpolation
" hi link rubyRailsMethod       Method
" hi link rubyRailsTestMethod   Keyword
" hi link rubyBlockParameter    Normal

" ----------------------------------------------------------------------------
" HTML Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link htmlTag Tag
hi link Tag Attribute
hi link htmlTagName Tag
hi link htmlSpecialTagName Tag
hi link htmlEndTag Tag
hi link htmlTagN Tag
hi link htmlArg Attribute

" ----------------------------------------------------------------------------
" XML Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link xmlTag Tag
hi link xmlTagName Tag
hi link xmlEndTag Tag
hi link xmlAttrib Attribute

" ----------------------------------------------------------------------------
" SQL Specific Syntax Highlighting
" ----------------------------------------------------------------------------

hi link sqlKeyword Statement
hi link sqlStatement Statement

