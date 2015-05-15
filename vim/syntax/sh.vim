" Vim indent file
" Language:         Shell Script
" Maintainer:       Clavelito <maromomo@hotmail.com>
" Id:               $Date: 2015-04-21 15:16:49+09 $
"                   $Revision: 3.35 $
"
" Description:      Set the following line if you do not use a mechanism to
"                   turn off Auto-indent in lines inside the double-quotes.
"                   let g:sh_indent_double_quote_auto_off = 0
"
"                   Specifies a string search quoting lines from the variable
"                   g:sh_indent_outside_quote_item. You can use regular
"                   expressions can be used by Vim. If the unlet or string
"                   empty to reset. The default value is the following line.
"                   '^\s*\%([^#].\{-}\|\d\)\=<<-\=\s*[^<]\|^\h\w*\s*(\s*)'
"
"                   Set the following line if you do not use a mechanism to
"                   turn off Auto-indent in quoting lines. Works even
"                   without the variable g:sh_indent_outside_quote_item.
"                   let g:sh_indent_auto_off = 0
"
"                   Set the following line if you do not want automatic
"                   indentation in the case labels.
"                   let g:sh_indent_case_labels = 0


if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetShIndent()
setlocal indentkeys+=0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,0=)
setlocal indentkeys+=0=fin,0=fil,0=fip,0=fir,0=fix
setlocal indentkeys-=:,0#

if exists("*GetShIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:OutSideQuoteItem = '^\h\w*\s*(\s*)'
let s:StartHereDocItem = '^\s*\%([^#].\{-}\|\d\)\=<<-\=\s*[^<]'
let s:OutSideQuoteItem = s:StartHereDocItem .'\|'. s:OutSideQuoteItem

if !exists("g:sh_indent_outside_quote_item")
  let g:sh_indent_outside_quote_item = s:OutSideQuoteItem
endif

if !exists("g:sh_indent_auto_off")
  let g:sh_indent_auto_off = 1
endif

if !exists("g:sh_indent_double_quote_auto_off")
  let g:sh_indent_double_quote_auto_off = 1
endif

if !exists("g:sh_indent_case_labels")
  let g:sh_indent_case_labels = 1
endif

function GetShIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  if exists("b:sh_indent_tabstop")
    let &tabstop = b:sh_indent_tabstop
    unlet b:sh_indent_tabstop
  endif

  let line = getline(lnum)
  let cline = getline(v:lnum)
  if g:sh_indent_auto_off
    if !exists("g:sh_indent_outside_quote_item")
          \ || empty(g:sh_indent_outside_quote_item)
      let g:sh_indent_outside_quote_item = s:OutSideQuoteItem
    endif

    let qinitdic = s:GetJoinLineAndQuoteInit(lnum)
    let joinline = qinitdic['line']
    call remove(qinitdic, 'line')
    if g:sh_indent_double_quote_auto_off
      if cline =~ '^\s*$' && qinitdic[lnum]
        return indent(lnum)
      elseif qinitdic[lnum]
        return indent(v:lnum)
      endif
    else
      if cline =~ '^\s*$' && qinitdic[lnum] % 2
        return indent(lnum)
      elseif qinitdic[lnum] % 2
        return indent(v:lnum)
      endif
    endif
  endif

  while 1
    let [snum, hnum, sstr] = s:GetHereDocItem(lnum, line)
    if hnum == lnum
      let [line, lnum] = [sstr, snum]
      break
    elseif hnum >= v:lnum
      let ind = indent(lnum)
      let cind = indent(v:lnum)
      let ind = s:InsideHereDocIndent(snum, hnum, sstr, cline, ind, cind)
      return ind
    elseif snum && hnum && hnum < snum || snum && !hnum
      return indent(lnum)
    else
      if line =~ '^\s*#' && s:GetPrevNonBlank(lnum)
        let lnum = s:prev_lnum
        let line = getline(lnum)
        unlet s:prev_lnum
        continue
      elseif g:sh_indent_auto_off && lnum > 1
            \ && min(keys(qinitdic)) && min(keys(qinitdic)) < lnum
            \ && line =~ '\\\@<!"\|\\\@<!\%o47' && qinitdic[lnum - 1]
        let [line, lnum] = s:SkipQuoteLine(line, lnum - 1, qinitdic)
        unlet! s:prev_lnum
        break
      else
        unlet! s:prev_lnum
        break
      endif
    endif
  endwhile

  let ind = indent(lnum)
  let [pline, pnum] = s:SkipCommentLine(line, lnum, 1)
  let [pline, ind] = s:MorePrevLineIndent(pline, pnum, line, ind)
  let ind = s:InsideCaseLabelIndent(pline, line, ind)
  let line = s:HideCaseLabelLine(line, pline)
  if g:sh_indent_auto_off && !empty(line)
    let ind = s:PrevLineIndent(line, lnum, pline, ind, joinline)
  elseif !empty(line)
    let ind = s:PrevLineIndent(line, lnum, pline, ind)
  endif
  let ind = s:CurrentLineIndent(cline, ind)

  return ind
endfunction

function s:MorePrevLineIndent(pline, pnum, line, ind)
  let ind = a:ind
  let pline = a:pline
  if a:pline !~ '\\$' && a:line =~ '\\$'
        \ && a:line !~ '\%(^\s*\|[^<]\)<<-\=\s*\\$'
        \ && a:pline !~# '^\s*case\>\|^\s*[^(].\{-})\s*case\>'
        \ && a:pline !~ ';;\s*\%(#.*\)\=$'
    let ind = ind + &sw
  elseif a:pline =~ '\\$' && a:line !~ '\\$'
    let pline = s:JoinContinueLine(a:pline, a:pnum)
    if pline !~# '^\s*case\>\|^\s*[^(].\{-})\s*case\>'
          \ && pline !~ ';;\s*\%(#.*\)\=$'
      let ind = ind - &sw
    endif
  endif

  return [pline, ind]
endfunction

function s:InsideCaseLabelIndent(pline, line, ind)
  let ind = a:ind
  if a:line =~# '^\s*esac\>\s*;;\s*\%(#.*\)\=$'
        \ && a:pline =~ ';;\s*\%(#.*\)\=$'
    let ind = ind - &sw
  elseif a:line =~ ';;\s*\%(#.*\)\=$'
        \ && a:pline !~# '^\s*case\>\|^\s*[^(].\{-})\s*case\>'
        \ && a:pline !~ ';;\s*\%(#.*\)\=$'
    let ind = ind - &sw
  elseif a:line =~ '^\s*[^(].\{-})' && a:line !~ ';;\s*\%(#.*\)\=$'
        \ && (a:pline =~# '^\s*case\>\|^\s*[^(].\{-})\s*case\>'
        \ || a:pline =~ ';;\s*\%(#.*\)\=$')
    let ind = ind + &sw
  endif

  return ind
endfunction

function s:PrevLineIndent(line, lnum, pline, ind, ...)
  let ind = a:ind
  if a:line =~# '^\s*\%(\h\w*\s*(\s*)\s*\)\=[{(]\s*\%(#.*\)\=$'
        \. '\|^\s*function\s\+\S\+\%(\s\+{\|\s*(\s*)\s*[{(]\)\s*\%(#.*\)\=$'
        \. '\|\%(;\|&&\|||\)\s*[{(]\s*\%(#.*\)\=$'
    let ind = ind + &sw
  elseif a:line !~ '^\s*#'
    let line = s:HideAnyItemLine(a:line, a:lnum)
    if line =~ '('
      let ind = ind + &sw * (len(split(line, '(', 1)) - 1)
    endif
    let ind = s:CloseParenIndent(a:line, a:pline, line, ind)
    if a:0 && line =~ '\\\@<!`' && len(split(a:1, '\\\@<!`', 1)) % 2
      let ind = ind - &sw
    elseif a:0 && line =~ '\\\@<!`'
      let ind = ind + &sw
    endif
    if line =~ '|\|&\|`\|('
      for line in split(line, '|\|&\|`\|(')
        if !empty(line)
          let ind = s:PrevLineIndent2(line, ind)
        endif
      endfor
    else
      let ind = s:PrevLineIndent2(line, ind)
    endif
  endif

  return ind
endfunction

function s:PrevLineIndent2(line, ind)
  let ind = a:ind
  if a:line =~# '^\s*\%(if\|then\|else\|elif\)\>'
        \ && a:line !~# ';\s*\<fi\>'
        \ || a:line =~# '^\s*\%(do\|while\|until\|for\)\>'
        \ && a:line !~# ';\s*\<done\>'
    let ind = ind + &sw
  elseif a:line =~# '^\s*case\>'
        \ && a:line !~# ';;\s*\<esac\>' && g:sh_indent_case_labels
    let ind = ind + &sw / g:sh_indent_case_labels
  endif

  return ind
endfunction

function s:CurrentLineIndent(cline, ind)
  let ind = a:ind
  if a:cline =~# '^\s*\%(then\|do\|else\|elif\|fi\|done\)\>'
        \ || a:cline =~ '^\s*[})]'
    let ind = ind - &sw
  elseif a:cline =~# '^\s*esac\>' && g:sh_indent_case_labels
    let ind = ind - &sw / g:sh_indent_case_labels
  endif

  return ind
endfunction

function s:CloseParenIndent(line, pline, nline, ind)
  let ind = a:ind
  if a:nline =~ ')'
        \ && a:pline !~# '^\s*case\>\|^\s*[^(].\{-})\s*case\>'
        \ && a:pline !~ ';;\s*\%(#.*\)\=$'
    if a:line =~ '^\s*)'
      let ind = ind + &sw
    endif
    let ind = ind - &sw * (len(split(a:nline, ')', 1)) - 1)
  endif

  return ind
endfunction

function s:SkipCommentLine(line, lnum, prev)
  let line = a:line
  let lnum = a:lnum
  if a:prev && s:GetPrevNonBlank(lnum)
    let lnum = s:prev_lnum
    let line = getline(lnum)
  endif
  while line =~ '^\s*#' && s:GetPrevNonBlank(lnum)
    let lnum = s:prev_lnum
    let line = getline(lnum)
  endwhile
  unlet! s:prev_lnum

  return [line, lnum]
endfunction

function s:JoinContinueLine(line, lnum)
  let line = a:line
  let lnum = a:lnum
  while line =~ '\\$' && s:GetPrevNonBlank(lnum)
    let lnum = s:prev_lnum
    let line = getline(lnum)
    let [line, lnum] = s:SkipCommentLine(line, lnum, 0)
  endwhile
  unlet! s:prev_lnum

  return line
endfunction

function s:GetPrevNonBlank(lnum)
  let s:prev_lnum = prevnonblank(a:lnum - 1)

  return s:prev_lnum
endfunction

function s:GetNextNonBlank(lnum)
  let s:next_lnum = nextnonblank(a:lnum + 1)

  return s:next_lnum
endfunction

function s:HideCaseLabelLine(line, pline)
  let line = a:line
  if a:line =~ '^\s*[^(].\{-})' && a:line !~ ';;\s*\%(#.*\)\=$'
        \ && (a:pline =~# '^\s*case\>' || a:pline =~ ';;\s*\%(#.*\)\=$')
    let line = substitute(line, '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"'
          \. '\|\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
    let line = substitute(line, '^\s*.\{-}\\\@<!)\s*\%(#.*$\)\=', '', '')
  elseif a:line =~ '\\$'
        \ && (a:pline =~# '^\s*case\>' || a:pline =~ ';;\s*\%(#.*\)\=$')
    let line = ""
  endif

  return line
endfunction

function s:HideAnyItemLine(line, lnum)
  let line = a:line
  if line =~ '\%(\${\h\w*#\=\|\${\=\|\\\)\@<!#'
    let sum = s:InsideCommentOrQuote(line)
    if sum
      let line = substitute(line, '^\(.\{' . sum . '}\)#.*$', '\1', '')
    endif
  endif
  if line =~ '"'
    let line = substitute(line, '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"', '', 'g')
  endif
  if line =~ '\%o47'
    let line = substitute(line,
          \ '\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
  endif
  if line =~ '(\|)\|`'
    let line = substitute(line,
          \ '\\[()]\|\$\=([^()]*\\\@<!)\|\(\\\@<!\\*`\).\{-}\\\@<!\1', '', 'g')
    let len = len(line)
    while 1
      let line = substitute(line, '\$\=([^()]*\\\@<!)', '', 'g')
      if len == len(line)
        break
      else
        let len = len(line)
      endif
    endwhile
  endif

  return line
endfunction

function s:GetHereDocPairLine(line, lnum)
  if a:line =~ '<<-\=\s*\\$' && s:GetNextNonBlank(a:lnum)
    let estr = getline(s:next_lnum)
    let estr = substitute(estr, '^\s*', '', '')
  elseif a:line =~ '<<-\=\s*\\$'
    let estr = ""
  else
    let estr = substitute(a:line, '^.\{-}<<-\=\s*\\\=', '', '')
  endif
  unlet! s:next_lnum
  if estr =~ "^'"
    let estr = substitute(estr, '^\%o47\([^' . "'" . ']\+\)\%o47.*$', '\1', '')
  elseif estr =~ '^"'
    let estr = substitute(estr, '^"\([^"]\+\)".*$', '\1', '')
  else
    let estr = substitute(estr, '\%(\s*|\|\s*>\|\s\+#\).*$', '', '')
  endif
  if !empty(estr) && a:line =~ '<<-'
    let estr = '\C\%(<<-\=\s*\\\n\)\@<!\_^\t*\M' . estr . '\m$'
  elseif !empty(estr)
    let estr = '\C\%(<<\s*\\\n\)\@<!\_^\M' . estr . '\m$'
  endif

  return estr
endfunction

function s:OnOrNotItem(line, item)
  let line = a:line
  if line =~ '\%(\${\h\w*#\=\|\${\=\|\\\)\@<!#'
    let sum = s:InsideCommentOrQuote(line)
    if sum
      let line = substitute(line, '^\(.\{' . sum . '}\)#.*$', '\1', '')
    endif
  endif
  let line = substitute(line, '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"'
        \. '\|\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')

  if line =~# a:item
    return 1
  else
    return 0
  endif
endfunction

function s:GetHereDocItem(lnum, line)
  let snum = 0
  let lnum = 0
  let onum = 0
  let line = ""
  let save_cursor = getpos(".")
  call cursor(a:lnum, len(a:line))
  while search(s:StartHereDocItem, 'bW')
    let lsum = line(".")
    let sstr = getline(lsum)
    if s:OnOrNotItem(sstr, '\%(^\s*\|[^<]\)<<-\=')
      let estr = s:GetHereDocPairLine(sstr, lsum)
    else
      continue
    endif
    if empty(estr)
      continue
    endif
    let lnum = search(estr, 'nW')
    if snum && !lnum && !onum
      continue
    elseif lnum && lnum < snum && !onum
      break
    endif
    let snum = lsum
    let line = sstr
    if lnum < onum
      let lnum = onum
      let snum = pnum
      let line = pline
      break
    elseif lnum > a:lnum
      break
    elseif snum && !lnum
      continue
    endif
    let onum = lnum
    let pnum = snum
    let pline = line
  endwhile
  call setpos('.', save_cursor)

  return [snum, lnum, line]
endfunction

function s:GetMostWidthSpaceLen(line)
  let idx = 0
  let spsum = 0
  while 1
    let idx = stridx(a:line, ' ', idx)
    if idx < 0
      break
    endif
    let len = matchend(a:line, ' *', idx) - idx
    if len > spsum
      let spsum = len
    endif
    let idx = idx + len
  endwhile

  return spsum
endfunction

function s:GetTabAndSpaceSum(cline, cind, sstr, sind)
  if a:cline =~ '^\t'
    let tbind = matchend(a:cline, '\t*', 0)
  else
    let tbind = 0
  endif
  let spind = a:cind - tbind * &sw
  if a:sstr =~ '<<-' && a:sind
    let tbind = a:sind / &sw
  endif

  return [tbind, spind]
endfunction

function s:InsideHereDocIndent(snum, lnum, sstr, cline, ind, cind)
  let ind = a:ind
  let snum = a:snum
  if snum && a:sstr =~ '<<-\s*\\$' && s:GetNextNonBlank(snum)
    let snum = s:next_lnum
  endif
  unlet! s:next_lnum
  if snum && !&expandtab
    let sind = indent(snum)
  endif
  if a:lnum > 0 && !&expandtab
    let spsum = s:GetMostWidthSpaceLen(a:cline)
  elseif a:lnum > 0 && &expandtab
    let eind = indent(a:lnum)
  endif
  if a:lnum > v:lnum && !&expandtab && spsum >= &sw
    let [tbind, spind] = s:GetTabAndSpaceSum(a:cline, a:cind, a:sstr, sind)
    let b:sh_indent_tabstop = &tabstop
    let &tabstop = spsum + 1
    let ind = tbind * &tabstop + spind
  elseif a:lnum >= v:lnum && !&expandtab && spsum < &sw && a:sstr =~ '<<-'
    let [tbind, spind] = s:GetTabAndSpaceSum(a:cline, a:cind, a:sstr, sind)
    let ind = tbind * &tabstop + spind
  elseif a:lnum >= v:lnum && &expandtab && eind && a:cline =~ '^\t'
    let tbind = matchend(a:cline, '\t*', 0)
    let ind = a:cind - tbind * &tabstop
  elseif a:lnum >= v:lnum
    let ind = a:cind
  endif

  return ind
endfunction

function s:GetJoinLineAndQuoteInit(lnum)
  let snum = search(g:sh_indent_outside_quote_item, 'nbW')
  let snum = snum ? snum : 1
  let qinit = 0
  let line = ""
  let qinitdic = {}
  while snum <= a:lnum
    let nline = getline(snum)
    let fline = nline
    if !qinit && nline =~ '^\s*#'
      let qinitdic[snum] = qinit
      let snum += 1
      continue
    elseif !qinit && nline =~ s:StartHereDocItem
          \ && s:OnOrNotItem(nline, '\%(^\s*\|[^<]\)<<-\=')
      let [slnum, hlnum, sstr] = s:GetHereDocItem(snum, fline)
      if slnum && hlnum > snum && hlnum < a:lnum
        while snum <= hlnum
          let qinitdic[snum] = qinit
          let snum += 1
        endwhile
        continue
      elseif slnum && hlnum && hlnum < slnum || slnum && !hlnum
        while snum <= a:lnum
          let qinitdic[snum] = qinit
          let snum += 1
        endwhile
        break
      endif
    elseif !qinit && nline =~ '\%(\${\h\w*#\=\|\${\=\|\\\)\@<!#'
      let sum = s:InsideCommentOrQuote(nline)
      if sum
        let nline = substitute(nline, '^\(.\{' . sum . '}\)#.*$', '\1', '')
      endif
    elseif qinit && nline =~ '\\\@<!"\|\\\@<!\%o47'
          \ && nline =~ '\%(\${\h\w*#\=\|\${\=\|\\\)\@<!#'
      let nline = s:HideCommentStr(nline, qinit)
    endif
    if !qinit && nline =~ '"'
      let nline = substitute(nline,
            \ '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"', '', 'g')
    endif
    if nline =~ '\%o47' && !qinit
      let nline = substitute(nline,
            \ '\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
    elseif nline =~ '\%o47' && qinit == 1
      let nline = substitute(nline, '\%o47.\{-}\\\@<!\%o47', '', 'g')
    endif
    if nline =~ '"\|\%o47\|`'
      if nline =~ '\\$'
        let nline = substitute(nline, '\\\+$', '', '')
      endif
      let line = line . nline
    endif

    if !qinit && nline =~ '\\\@<!"\|\\\@<!\%o47'
      let init1 = len(split(line, '\\\@<!\%o47', 1)) % 2
      let init2 = len(split(line, '\\\@<!"', 1)) % 2
      if init1 && init2
        let line = substitute(line, '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"'
              \. '\|\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
        let qinit = 0
      elseif !init1 && init2
        let line = substitute(line,
              \ '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"', '', 'g')
        let qinit = 1
      elseif init1 && !init2
        let line = substitute(line,
              \ '\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
        let qinit = 2
      else
        let qinit = s:InsideCommentOrQuote(fline, qinit)
      endif
    elseif qinit == 2 && nline =~ '\\\@<!"'
          \ && len(split(line, '\\\@<!"', 1)) % 2
      let line = substitute(line, '\(\\\@<!\\*"\).\{-}\\\@<!\1\|\\\+"', '', 'g')
      let qinit = s:InsideQuoteReverse(nline, qinit)
    elseif qinit == 1 && nline =~ '\\\@<!\%o47'
          \ && len(split(line, '\\\@<!\%o47', 1)) % 2
      let line = substitute(line,
            \. '\%o47.\{-}\\\@<!\%o47\|\%o47.\{-}\%o47\|\\\+\%o47', '', 'g')
      let qinit = s:InsideQuoteReverse(nline, qinit)
    endif
    let qinitdic[snum] = qinit
    let snum += 1
  endwhile
  let qinitdic['line'] = line

  return qinitdic
endfunction

function s:SkipQuoteLine(line, lnum, qinitdic)
  let lnum = a:lnum
  let lmin = min(keys(a:qinitdic))
  while s:GetPrevNonBlank(lnum)
        \ && lmin <= s:prev_lnum && a:qinitdic[s:prev_lnum]
    let lnum = s:prev_lnum
  endwhile
  unlet! s:prev_lnum
  let line = getline(lnum). a:line

  return [line, lnum]
endfunction

function s:InsideCommentOrQuote(line, ...)
  let line = a:line
  let cnum = len(line)
  let squote = 0
  let dquote = 0
  let bslash = 0
  let ssum = 0
  let sum = matchend(line, '\%(\${\h\w*#\=\|\${\=\|\\\)#')
  while sum > 0
    let ssum = sum
    let sum = matchend(line, '\%(\${\h\w*#\=\|\${\=\|\\\)#', sum)
  endwhile
  let sum = 0
  while sum < cnum
    let str = strpart(line, sum, 1)
    if str == '#' && !squote && !dquote && !bslash && sum > ssum && !a:0
      return sum
    elseif str == '#' && !squote && !dquote && !bslash && sum > ssum
      break
    elseif str == '\'
      let bslash += 1
    elseif str == "'" && !squote && !dquote && !bslash
      let squote = 1
      let bslash = 0
    elseif str == "'" && squote
      let squote = 0
      let bslash = 0
    elseif str == '"' && !squote && !dquote && !bslash
      let dquote = -1
    elseif str == '"' && !squote && !dquote && bslash
      let dquote = bslash
      let bslash = 0
    elseif str == '"' && (dquote < 0 && !bslash || dquote == bslash)
      let dquote = 0
      let bslash = 0
    else
      let bslash = 0
    endif
    let sum += 1
  endwhile

  if a:0 && a:1 != 1 && squote
    return 1
  elseif a:0 && a:1 != 2 && dquote
    return 2
  else
    return 0
  endif
endfunction

function s:InsideQuoteReverse(line, init)
  let line = a:line
  if a:init == 1
    let line = substitute(line, '^.\{-}\\\@<!\%o47', '', '')
  elseif a:init == 2
    let line = substitute(line, '^.\{-}\\\@<!"', '', '')
  endif
  let sum = len(line) - 1
  let squote = 0
  let dquote = 0
  while sum > 0
    let str = strpart(line, sum, 1)
    if str == '\' && (squote == sum + 1 || dquote == sum + 1)
      let squote = 0
      let dquote = 0
    elseif str == "'" && !squote && !dquote
      let squote = sum
    elseif str == "'" && squote
      let squote = 0
    elseif str == '"' && !squote && !dquote
      let dquote = sum
    elseif str == '"' && dquote
      let dquote = 0
    endif
    let sum -= 1
  endwhile

  if a:init == 1 && dquote
    return 2
  elseif a:init == 2 && squote
    return 1
  else
    return 0
  endif
endfunction

function s:HideCommentStr(line, init)
  let nline = a:line
  if a:init == 1
    let hline = substitute(nline, '\(^.\{-}\\\@<!\%o47\).*$', '\1', '')
  elseif a:init == 2
    let hline = substitute(nline, '\(^.\{-}\\\@<!"\).*$', '\1', '')
  endif
  let tline = substitute(nline, '^'. hline, '', '')
  if tline =~ '^\s*#'
    let tline = ""
  else
    let sum = s:InsideCommentOrQuote(tline)
    if sum
      let tline = substitute(tline, '^\(.\{' . sum . '}\)#.*$', '\1', '')
    endif
  endif
  let nline = hline . tline

  return nline
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set sts=2 sw=2 expandtab smarttab:
