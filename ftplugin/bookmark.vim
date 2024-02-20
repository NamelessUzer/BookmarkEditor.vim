﻿" Vim ftplugin file
" Language:	bookmark
" Maintainer: Lin Kun <Kun.Lin # qq.com>
" Last Change: 2024 Jun 25

augroup filetype_bookmark
    autocmd!
    " autocmd FileType bookmark setlocal noexpandtab
    " 上面这行配置会被覆盖，因而不够可靠使用下面这行更晚的事件来触发 setlocal noexpandtab，从而避免被覆盖
    autocmd VimEnter,BufEnter *.bookmark setlocal noexpandtab
    autocmd BufWritePre,FileWritePre *.bookmark FormatBookmark
augroup END

function! s:FormatBookmark()
  silent! g/^\s\+$/d _
  silent! %s/ \{4}/\t/ge
  silent! %s/^\(\s*第\)\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*\(部分\?\|分\?编\|小\?节\|\|[章讲条]\)\s*/\1\2\3 /ge
  silent! %s/\%(\s\|[.⋯/／　]\)*\(-\?\d\+\(\s\/XYZ\(\s\d\+\(\.\d\+\)\?\)\{3}\)\?\)\s*$/\t\1/ge
  silent! %s/\D\zs\s*\(-\?\)$/\t\1/ge
  silent! %s/\(^\|\t\)\zs[ 　]\+\|[ 　]\+\ze\t//ge
  " 删除行首或制表符旁边的数量少于3个的空格，因为前文已经将4个空格替换为一个制表符，所以此处的空格数量不会大于3个，这样的空格通常是意外操作引起的，删除之。
  silent! %s/[(（]\([^()（）]*[\u4E00-\u9FFF]\+[^()（）]*\)[)）]/（\1）/ge
  silent! %s/[（(]\([-0-9a-zA-Z,:;.?!'; ]\+\)[)）]/(\1)/ge
endfunction
function! s:StructureContentText2Bookmark() range
  let l:unnamed = getreg('"')
  let l:lines = getline(1, '$')
  call map(l:lines, 'trim(v:val)')
  call map(l:lines, 'substitute(v:val, "[ 　]\\+", " ", "g")')
  call map(l:lines, 'trim(v:val)')
  call filter(l:lines, 'strlen(v:val)')
  call map(l:lines, 'substitute(v:val, "\\%(\\s\\|[.⋯/／　]\\)*\\(-\\?\\d\\+\\(\\s/XYZ\\(\\s\\d\\+\\(\\.\\d\\+\\)\\?\\)\\{3}\\)\\?\\)\\s*$", "\\t\\1", "ge")')
  " 章节标题与页码之间的分隔符号统一替换为一个Tab。
  call map(l:lines, 'substitute(v:val, "[\\u4E00-\\u9FFF、，：；。？！‘’“”（）【】《》—]\\zs\\s\\+\\ze[\u4E00-\\u9FFF、，：；。？！‘’“”（）【】《》—]", "", "g")')
  " 删除汉字、全角标点之间的空白符号
  let partLevel = ""
  let subPartLevel = ""
  let chapterLevel = ""
  let sectionLevel = ""
  let subsectionLevel = ""
  let itemLevel = ""
  let numLevel = ""
  " 默认卷、部、部分、编、章、节、条的等级都是一级，即不需要缩进，如果发现存在上一级标题，就将其下所有等级的标题降一级；
  " 例如，发现“部分、部、编”，就将“章”、“节”、“条”的标题等级降一级，同理，如果发现“章”，就将“节”、“条”的标题等级降一级
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)\(部分\?\|卷\)\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\(部分\\?\\|卷\\)\\)\\s*", "' . partLevel    . '\\1 ", "")')
    let subPartLevel .= "\t"
    let chapterLevel .= "\t"
    let subsectionLevel .= "\t"
    let sectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)编\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)编\\)\\s*", "' . subPartLevel    . '\\1 ", "")')
    let chapterLevel .= "\t"
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)\([章讲回]\|单元\)\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\([章讲回]\\|单元\\)\\)\\s*", "' . chapterLevel . '\\1 ", "")')
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  elseif match(l:lines, '^\(专题\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\|\d\+\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(专题\\s*\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\|\\d\\+\\)\\s*", "' . chapterLevel . '\\1 ", "")')
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)节\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)节\\)\\s*", "' . sectionLevel . '\\1 ", "")')
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(\([零一二三四五六七八九十百千万]\+\|\d\+\)、\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)、\\)\\s*", "' . subsectionLevel . '\\1 ", "")')
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)条\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)条\\(之[零一二三四五六七八九十百千]\\+\\)\\?\\)\\s*", "' . itemLevel . '\\1 ", "")')
    let numLevel .= "\t"
  endif
  call map(l:lines, 'substitute(v:val, "^\\(\\(\\d\\+\\.\\)\\+\\d*\\)\\s*", "' . numLevel . '\\1 ", "")')

  execute("%delete")
  call setline(1, l:lines)
  execute '1,$-1s/\n\+/\r/g'
  call setpos(".", [0, 1, 1, 0])
  call setreg('"', l:unnamed)
  unlet l:lines
  unlet l:unnamed
endfunction

command! -nargs=0 -range=% StructureContentText2Bookmark : <line1>,<line2>call <SID>StructureContentText2Bookmark()
command! -nargs=0 FormatBookmark : <line1>,<line2>call <SID>FormatBookmark()
nnoremap <silent> <Plug>StructureContentText2Bookmark    : StructureContentText2Bookmark<cr>
nnoremap <silent> <Plug>FormatBookmark    : FormatBookmark<cr>
