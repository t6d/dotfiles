set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "t6d"

" hi Normal
hi LineNr ctermfg=235 ctermbg=none
hi CursorLine cterm=none
hi StatusLine cterm=none ctermfg=255 ctermbg=235
hi StatusLineNC cterm=none ctermfg=244 ctermbg=233
hi VertSplit cterm=none ctermfg=235 ctermbg=none
hi Search cterm=underline ctermfg=none ctermbg=none
hi IncSearch cterm=underline ctermfg=none ctermbg=none
hi NonText ctermfg=235
hi SpecialKey ctermfg=235

" hi ColumnMargin
" hi Error
" hi ErrorMsg
" hi Folded
" hi FoldColumn
" hi ModeMsg
" hi Pmenu
" hi PmenuSel
" hi PmenuSbar
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

hi link Pmenu StatusLineNC
hi link PmenuSel StatusLine
hi PmenuSbar ctermfg=233 ctermbg=233
hi PmenuThumb ctermfg=235 ctermbg=235

" ----------------------------------------------------------------------------
" Diff Highlighting
" ----------------------------------------------------------------------------

hi DiffFile ctermfg=244
hi link DiffNewFile DiffFile
hi DiffLine cterm=underline ctermfg=255
hi clear DiffAdd
hi clear DiffDelete
hi clear DiffChange
hi DiffAdd ctermfg=34
hi DiffDelete ctermfg=196
hi DiffChange ctermfg=214
hi link DiffAdded DiffAdd
hi link DiffRemoved DiffDelete

" ----------------------------------------------------------------------------
" Syntax Highlighting
" ----------------------------------------------------------------------------

hi Comment ctermfg=238
hi Type ctermfg=214
hi Identifier ctermfg=39
hi Keyword ctermfg=196
hi Statement ctermfg=196
hi PreProc ctermfg=43
hi Symbol ctermfg=202
hi String ctermfg=112
hi Interpolation ctermfg=190
hi Attribute ctermfg=202
hi Tag ctermfg=214

hi Underlined cterm=underline ctermfg=None ctermbg=None
hi Special ctermfg=255

hi Directory ctermfg=39

hi link Method Type
hi link Function Method
hi link Structure Type
hi link Constant Type
hi link Number Symbol
hi link Macro Normal

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

