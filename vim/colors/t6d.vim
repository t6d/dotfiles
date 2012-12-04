" Vim color file
" Converted from Textmate theme t6d using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "t6d"

hi Cursor ctermfg=232 ctermbg=254 cterm=NONE guifg=#080808 guibg=#e6e6e6 gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#53545e gui=NONE
hi CursorLine ctermfg=NONE ctermbg=234 cterm=NONE guifg=NONE guibg=#1e1e1e gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE guifg=NONE guibg=#1e1e1e gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=234 cterm=NONE guifg=NONE guibg=#1e1e1e gui=NONE
hi VertSplit ctermfg=238 ctermbg=238 cterm=NONE guifg=#484848 guibg=#484848 gui=NONE
hi MatchParen ctermfg=196 ctermbg=NONE cterm=underline guifg=#fc002f guibg=NONE gui=underline
hi StatusLine ctermfg=254 ctermbg=238 cterm=bold guifg=#e6e6e6 guibg=#484848 gui=bold
hi StatusLineNC ctermfg=254 ctermbg=238 cterm=NONE guifg=#e6e6e6 guibg=#484848 gui=NONE
hi Pmenu ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#53545e gui=NONE
hi IncSearch ctermfg=232 ctermbg=34 cterm=NONE guifg=#080808 guibg=#2cb114 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi Folded ctermfg=244 ctermbg=232 cterm=NONE guifg=#808080 guibg=#080808 gui=NONE

hi Normal ctermfg=254 ctermbg=232 cterm=NONE guifg=#e6e6e6 guibg=#080808 gui=NONE
hi LineNr ctermfg=254 ctermbg=232 cterm=NONE guifg=#808080 guibg=#080808 gui=NONE
hi Boolean ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi Character ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi Comment ctermfg=244 ctermbg=NONE cterm=NONE guifg=#808080 guibg=NONE gui=italic
hi Conditional ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi DiffAdd ctermfg=254 ctermbg=64 cterm=bold guifg=#e6e6e6 guibg=#407d06 gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#850202 guibg=NONE gui=NONE
hi DiffChange ctermfg=254 ctermbg=17 cterm=NONE guifg=#e6e6e6 guibg=#142948 gui=NONE
hi DiffText ctermfg=254 ctermbg=24 cterm=bold guifg=#e6e6e6 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi Function ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi Identifier ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi Keyword ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi Label ctermfg=34 ctermbg=NONE cterm=NONE guifg=#2cb114 guibg=NONE gui=NONE
hi NonText ctermfg=239 ctermbg=233 cterm=NONE guifg=#4c4c4c guibg=#131313 gui=NONE
hi Number ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi Operator ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi PreProc ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi Special ctermfg=254 ctermbg=NONE cterm=NONE guifg=#e6e6e6 guibg=NONE gui=NONE
hi SpecialKey ctermfg=239 ctermbg=234 cterm=NONE guifg=#4c4c4c guibg=#1e1e1e gui=NONE
hi Statement ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi StorageClass ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi String ctermfg=34 ctermbg=NONE cterm=NONE guifg=#2cb114 guibg=NONE gui=NONE
hi Tag ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi Title ctermfg=254 ctermbg=NONE cterm=bold guifg=#e6e6e6 guibg=NONE gui=bold
hi Todo ctermfg=244 ctermbg=NONE cterm=inverse,bold guifg=#808080 guibg=NONE gui=inverse,bold,italic
hi Type ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi rubyFunction ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi rubyConstant ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=34 ctermbg=NONE cterm=NONE guifg=#2cb114 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi rubyInclude ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi rubyRegexp ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyEscape ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi rubyControl ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi rubyOperator ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi rubyException ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=119 ctermbg=NONE cterm=NONE guifg=#7af040 guibg=NONE gui=NONE
hi erubyComment ctermfg=244 ctermbg=NONE cterm=NONE guifg=#808080 guibg=NONE gui=italic
hi erubyRailsMethod ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=196 ctermbg=NONE cterm=NONE guifg=#fc002f guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi yamlAlias ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=34 ctermbg=NONE cterm=NONE guifg=#2cb114 guibg=NONE gui=NONE
hi cssURL ctermfg=45 ctermbg=NONE cterm=NONE guifg=#1bc5fe guibg=NONE gui=NONE
hi cssFunctionName ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fece18 guibg=NONE gui=NONE
hi cssColor ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi cssClassName ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi cssValueLength ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=202 ctermbg=NONE cterm=NONE guifg=#fc440b guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
