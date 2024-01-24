" Vim ftplugin file
" Language:	bookmark
" Maintainer: Lin Kun <Kun.Lin # qq.com>
" Last Change: 2024 Jun 23

function! s:FormatBookmark()
  silent! %s/ \{4}/\t/g
  silent! %s/^\s*第[零一二三四五六七八九十百千万]\+\(部分\?\|分\?编\|[章节条]\)\zs\s*/ /g
  silent! %s/\(\s\|[.⋯/／]\)*\(-\?\d\+\)\s*$/\t\2/g
  silent! %s/\D\zs\s*\(-\?\)$/\t\1/g
  silent! %s/[(（]\([^()（）]*[\x4e00-\u9fff]\+[^()（）]*\)[)）]/（\1）/g
  silent! %s/[（(]\([-0-9a-zA-Z,:;.?!'; ]\+\)[)）]/(\1)/g
endfunction
function! s:StructureContentText2Bookmark() range
  let l:unnamed = getreg('"')
  let l:lines = getline(1, '$')
  call map(l:lines, 'trim(v:val)')
  call map(l:lines, 'substitute(v:val, "[ 　]\\+", " ", "g")')
  call map(l:lines, 'trim(v:val)')
  call filter(l:lines, 'strlen(v:val)')
  call map(l:lines, 'substitute(v:val, "\\(\\s\\|[.⋯/／]\\)*\\(-\\?\\d\\+\\)\\s*$", "\\t\\2", "")')
  " 章节标题与页码之间的分隔符号统一替换为一个Tab。
  call map(l:lines, 'substitute(v:val, "[\\u4E00-\\u9FFF]\\zs\\s\\+\\ze[\u4E00-\\u9FFF]", "", "g")')
  " 删除汉字之间的空白符号
  let partLevel = ""
  let subPartLevel = ""
  let chapterLevel = ""
  let sectionLevel = ""
  let subsectionLevel = ""
  let itemLevel = ""
  let numLevel = ""
  " 默认卷、部、部分、编、章、节、条的等级都是一级，即不需要缩进，如果发现存在上一级标题，就将其下所有等级的标题降一级；
  " 例如，发现“部分、部、编”，就将“章”、“节”、“条”的标题等级降一级，同理，如果发现“章”，就将“节”、“条”的标题等级降一级
  if match(l:lines, '^\(第[零一二三四五六七八九十百千万]\+\(部分\?\|卷)\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第[零一二三四五六七八九十百千万]\\+\\(部分\\?\\|卷\\)\\)\\s*", "' . partLevel    . '\\1 ", "")')
    let subPartLevel .= "\t"
    let chapterLevel .= "\t"
    let subsectionLevel .= "\t"
    let sectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第[零一二三四五六七八九十百千万]\+编\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第[零一二三四五六七八九十百千万]\\+编\\)\\s*", "' . subPartLevel    . '\\1 ", "")')
    let chapterLevel .= "\t"
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第[零一二三四五六七八九十百千万]\+[章讲]\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第[零一二三四五六七八九十百千万]\\+[章讲]\\)\\s*", "' . chapterLevel . '\\1 ", "")')
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  elseif match(l:lines, '^\(专题\s*[零一二三四五六七八九十百千万]\+\|\d\+\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(专题\\s*[零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\s*", "' . chapterLevel . '\\1 ", "")')
    let sectionLevel .= "\t"
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第[零一二三四五六七八九十百千万]\+节\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第[零一二三四五六七八九十百千万]\\+节\\)\\s*", "' . sectionLevel . '\\1 ", "")')
    let subsectionLevel .= "\t"
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\([零一二三四五六七八九十百千万]\+、\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\([零一二三四五六七八九十百千万]\\+、\\)\\s*", "' . subsectionLevel . '\\1 ", "")')
    let itemLevel .= "\t"
    let numLevel .= "\t"
  endif
  if match(l:lines, '^\(第[零一二三四五六七八九十百千万]\+条\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第[零一二三四五六七八九十百千万]\\+条\\(之[零一二三四五六七八九十百千]\\+\\)\\?\\)\\s*", "' . itemLevel . '\\1 ", "")')
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
