﻿" Vim ftplugin file
" Language:	bookmark
" Maintainer: Lin Kun <Kun.Lin # qq.com>
" Last Change: 2025 May 20

function! bookmark#FormatBookmark()
  silent! g/^\s\+$/d _
  silent! %s/ \{4}/\t/ge
  silent! %s/^\(第\)\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*\(部分\?\|分\?编\|小\?节\|[篇章讲条]\)\s*/\1\2\3 /ge
  silent! %s/\%(\s\|[.⋯/／　]\)*\(-\?\d\+\(\s\/XYZ\(\s\d\+\(\.\d\+\)\?\)\{3}\)\?\)\s*$/\t\1/ge
  silent! %s/\D\zs\s*\(-\?\)$/\t\1/ge
  silent! %s/\(^\|\t\)\zs[ 　]\+\|[ 　]\+\ze\t//ge
  " 删除行首或制表符旁边的数量少于3个的空格，因为前文已经将4个空格替换为一个制表符，所以此处的空格数量不会大于3个，这样的空格通常是意外操作引起的，删除之。
  silent! %s/[(（]\([^()（）]*[\u4E00-\u9FFF]\+[^()（）]*\)[)）]/（\1）/ge
  silent! %s/[（(]\([-0-9a-zA-Z,:;.?!'; ]\+\)[)）]/(\1)/ge

  " 添加vim-repeat支持
  silent! call repeat#set("\<Plug>(FormatBookmark)", v:count)
endfunction

function! bookmark#StructureContentText2Bookmark() range
  call bookmark#FormatBookmark()
  let l:unnamed = getreg('"')
  let l:lines = getline(1, '$')
  call map(l:lines, 'trim(v:val)')
  call map(l:lines, 'substitute(v:val, "[ 　]\\+", " ", "g")')
  call map(l:lines, 'trim(v:val)')
  call filter(l:lines, 'strlen(v:val)')
  call map(l:lines, 'substitute(v:val, "\\s*[（()]\\s*\\(-\\?\\d\\+\\)\\s*[)）]\\s*$", "\\t\\1", "g")')
  " 删除包裹行尾页码的圆括号。
  call map(l:lines, 'substitute(v:val, "\\%(\\s\\|[.·⋯…/／　]\\)*\\(-\\?\\d\\+\\(\\s/XYZ\\(\\s\\d\\+\\(\\.\\d\\+\\)\\?\\)\\{3}\\)\\?\\)\\s*$", "\\t\\1", "ge")')
  " 章节标题与页码之间的分隔符号统一替换为一个Tab。
  call map(l:lines, 'substitute(v:val, "[\\u4E00-\\u9FFF、，：；。？！‘’“”（）【】《》—]\\zs\\s\\+\\ze[\u4E00-\\u9FFF、，：；。？！‘’“”（）【】《》—]", "", "g")')
  " 删除汉字、全角标点之间的空白符号
  let partIndent = ""
  let subPartIndent = ""
  let chapterIndent = ""
  let sectionIndent = ""
  let subsectionIndent = ""
  let itemIndent = ""
  let numIndent = ""
  " 默认卷、部、部分、编、章、节、条的等级都是一级，即不需要缩进，如果发现存在上一级标题，就将其下所有等级的标题降一级；
  " 例如，发现“部分、部、编”，就将“章”、“节”、“条”的标题等级降一级，同理，如果发现“章”，就将“节”、“条”的标题等级降一级
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)\(部分\?\|卷\)\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\(部分\\?\\|卷\\)\\)\\s*", "' . partIndent    . '\\1 ", "")')
    let subPartIndent .= "\t"
    let chapterIndent .= "\t"
    let subsectionIndent .= "\t"
    let sectionIndent .= "\t"
    let itemIndent .= "\t"
    let numIndent .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)[篇编]\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)[篇编]\\)\\s*", "' . subPartIndent    . '\\1 ", "")')
    let chapterIndent .= "\t"
    let sectionIndent .= "\t"
    let subsectionIndent .= "\t"
    let itemIndent .= "\t"
    let numIndent .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)\([章讲回]\|单元\)\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\([章讲回]\\|单元\\)\\)\\s*", "' . chapterIndent . '\\1 ", "")')
    let sectionIndent .= "\t"
    let subsectionIndent .= "\t"
    let itemIndent .= "\t"
    let numIndent .= "\t"
  elseif match(l:lines, '^\(专题\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\|\d\+\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(专题\\s*\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)\\|\\d\\+\\)\\s*", "' . chapterIndent . '\\1 ", "")')
    let sectionIndent .= "\t"
    let subsectionIndent .= "\t"
    let itemIndent .= "\t"
    let numIndent .= "\t"
  endif
  let l:numPartPattern = '^\(\d\+\(\.\d\+\)\+\)\s*'
  if match(l:lines, l:numPartPattern) >= 0
    for l:index in range(len(l:lines) - 1)
      " 提取当前行
      let l:line = l:lines[l:index]
      " 计算点的数量，确定需要添加的额外缩进
      if l:line =~ l:numPartPattern
        " 提取序号部分
        let l:number_part = matchstr(l:line, l:numPartPattern)
        " 基于序号部分计算点的数量
        let l:additional_indent = repeat("\t", len(split(l:number_part, '\.')) - 1)
        " 修正标题序号后的空格数量为一个
        let l:line = substitute(l:line, l:numPartPattern, '\1 ', '')
        " 应用缩进（额外缩进 + sectionIndent）和修正过的行内容
        let l:lines[l:index] = l:additional_indent . chapterIndent . l:line
      endif
    endfor
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)小\?节\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)小\\?节\\)\\s*", "' . sectionIndent . '\\1 ", "")')
    let subsectionIndent .= "\t"
    let itemIndent .= "\t"
    let numIndent .= "\t"
  endif
  if match(l:lines, '^\(\([零一二三四五六七八九十百千万]\+\|\d\+\)、\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)、\\)\\s*", "' . subsectionIndent . '\\1 ", "")')
    let itemIndent .= "\t"
    let numIndent .= "\t"
  endif
  if match(l:lines, '^\(第\([零一二三四五六七八九十百千万]\+\|\d\+\)条\)\s*') >= 0
    call map(l:lines, 'substitute(v:val, "^\\(第\\([零一二三四五六七八九十百千万]\\+\\|\\d\\+\\)条\\(之[零一二三四五六七八九十百千]\\+\\)\\?\\)\\s*", "' . itemIndent . '\\1 ", "")')
    let numIndent .= "\t"
  endif
  call map(l:lines, 'substitute(v:val, "^\\(\\(\\d\\+\\.\\)\\+\\d*\\)\\s*", "' . numIndent . '\\1 ", "")')

  execute("%delete")
  call setline(1, l:lines)
  execute '1,$-1s/\n\+/\r/g'
  call setpos(".", [0, 1, 1, 0])
  call setreg('"', l:unnamed)
  unlet l:lines
  unlet l:unnamed

  " 添加vim-repeat支持
  silent! call repeat#set("\<Plug>StructureContentText2Bookmark", v:count)
endfunction

function! bookmark#CopyPageNumber(mode = 'normal')
  let l:nextLineModeList = ['normal', 'minusOne', 'lastOdd']
  let l:lastLineModeList = ['increaseOne', 'nextOdd']
  let l:pageNumberPattern = '\v\s*\zs(-?\d+)\ze(\s/XYZ(\s\d+(\.\d+)?){3})?\s*$'

  " 保存当前光标位置
  let l:curpos = getpos(".")

  if index(l:nextLineModeList, a:mode) != -1
    " 判断当前行是否是最后一行
    if line('.') == line('$')
      echo "This is the last line."
      return
    endif
    " 获取下一行的行号
    let nextLineNum = line('.') + 1
    " 获取下一行的内容
    let nextLineString = getline(nextLineNum)
    " 获取下一行中的页码
    let l:pageNumberInNextLine = matchstr(nextLineString, l:pageNumberPattern)
    if empty(l:pageNumberInNextLine)
      echo "No page number found in the next line."
      return
    else
      " 根据参数决定拷贝方式
      if a:mode == 'normal'
        " normal模式表示直接复制下一行中的页码，适用于章节标题不单独成页的情况
        let l:pageNumberToPaste = l:pageNumberInNextLine
      elseif a:mode == 'minusOne'
        " minusOne模式表示复制下一行中的页码并减1，适用于章节标题单独成页并布置在前一页的情况
        let l:pageNumberToPaste = l:pageNumberInNextLine - 1
      elseif a:mode == 'lastOdd'
        " lastOdd模式表示复制下一行中的页码并减1或2得到上一个奇数页码，适用于章节标题单独成页并布置在奇数页的情况
        let l:pageNumberToPaste = l:pageNumberInNextLine % 2 == 0 ? l:pageNumberInNextLine - 1 : l:pageNumberInNextLine - 2
      endif
    endif
  elseif index(l:lastLineModeList, a:mode) != -1
    if line('.') == 1
      echo "This is the first line."
      return
    endif
    " 获取上一行的行号
    let lastLineNum = line('.') - 1
    " 获取上一行的内容
    let lastLineString = getline(lastLineNum)
    " 获取上一行中的页码
    let l:pageNumberInLastLine = matchstr(lastLineString, l:pageNumberPattern)
    if empty(l:pageNumberInLastLine)
      echo "No page number found in the last line."
      return
    else
      " 根据参数决定拷贝方式
      if a:mode == 'increaseOne'
        " increaseOne模式表示复制上一行中的页码并加1，适用于章节标题单独成页的情况
        let l:pageNumberToPaste = l:pageNumberInLastLine + 1
      elseif a:mode == 'nextOdd'
        " nextOdd模式表示复制上一行的页码并加1或2得到下一个奇数页码，适用于章节标题单独成页并布置在奇数页的情况
        let l:pageNumberToPaste = l:pageNumberInLastLine % 2 == 0 ? l:pageNumberInLastLine + 1 : l:pageNumberInLastLine + 2
      endif
    endif
  else
    echo "Invalid mode."
    return
  endif

  " 使用:s命令修改当前行的页码为新页码
  execute "normal! :s/\\v\\s*(-?\\d+)?(\\s\\/XYZ(\\s\\d+(\\.\\d+)?){3})?\\s*$/\\t" . l:pageNumberToPaste . "/e\<CR>"

  " 注册可重复操作
  let l:mode_camel = substitute(a:mode, '$\l$$\w*$', '\=toupper(submatch(1)) . submatch(2)', '')
  silent! call repeat#set(printf("\<Plug>(BookmarkCopy%s)", l:mode_camel), v:count)

  " 恢复光标到原始行，并尝试定位到页码末尾或行尾
  call cursor(l:curpos[1], 1) " 移动到当前行的开始
  let l:lineContent = getline('.')
  let l:pageNumMatch = matchlist(l:lineContent, '\v\s*(-?\d+)(\s/XYZ(\s\d+(\.\d+)?){3})?\s*$')
  if len(l:pageNumMatch) > 0
    " 如果当前行有页码，定位到页码末尾位置
    let l:pageNumStartPos = match(l:lineContent, '\v\s*(-?\d+)(\s/XYZ(\s\d+(\.\d+)?){3})?\s*$')
    let l:pageNum = l:pageNumMatch[1]
    let l:pageNumEndPos = l:pageNumStartPos + len(l:pageNum)
    call cursor(l:curpos[1], l:pageNumEndPos + 1)
  else
    " 如果没有页码，定位到行尾
    call cursor(l:curpos[1], col('$'))
  endif
endfunction

" 定义错误类型和匹配规则
let s:bookmarkErrors = {
\   'E001': {'pattern': '\v\s*(-?\D+)\ze(\s/XYZ(\s\d+(\.\d+)?){3})?\s*$', 'description': '缺少页码'}
\  ,'E002': {'pattern': '\v^\s*\zs(-?\d+)\ze\s*$', 'description': '只有页码'}
\}

function! bookmark#CheckBookmark()
  call bookmark#FormatBookmark()
  call setqflist([])
  let qf_list = []

  let lines = getline(1, '$')
  for i in range(len(lines))
    let line = lines[i]
    for [errorType, error] in items(s:bookmarkErrors)
      let colnr_end = matchend(line, error['pattern'])
      if colnr_end != -1
        let colnr_end = colnr_end + 1
        call add(qf_list, {'filename': expand('%'), 'lnum': i + 1, 'col': colnr_end, 'text': errorType . ': ' . error['description']})
        break
      endif
    endfor
  endfor

  if !empty(qf_list)
    call setqflist(qf_list)
    copen
  else
    echo '未发现错误'
  endif

  " 添加vim-repeat支持
  silent! call repeat#set("\<Plug>(CheckBookmark)", v:count)
endfunction
