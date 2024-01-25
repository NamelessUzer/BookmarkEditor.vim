" Vim syntax file
" Language:	bookmark
" Maintainer:	Lin Kun <Kun.Lin # qq.com>
" Last Change:	2024 Jun 22


if exists("b:current_syntax")
  finish
endif

syntax clear

" 定义书签不同层级的正则表达式匹配规则
syntax match NonMain "^\s*\zs\(\(封皮\|封面\|书名\|版权\)页\?\|扉页\)\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\([总分]\?目录\|简目\|详目\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\(\d\{4}\s*年\?版\?\)\?\([前自再代总]序\|[前导弁引]言\|序[文言]\?\|代总序\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\(绪论\|编者的话\|摘要\|内容摘要\|关键词\|缩略语\|术语表\|法律声明\|读者对象\|注释\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\(作者简介\|关于作者\|作者\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\(索引\|后\?附录\|结语\|后记\|封底\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match NonMain "^\s*\zs\(第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*版\)\(前言\|序言\?\)\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\s*\)\?$"
syntax match BookmarkPart "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*\(部分\?\|卷\).\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkSubpart "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*编.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkChapter "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*[章讲].\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkChapter "^\s*\zs专题\s*\([零一二三四五六七八九十百千万]\+\|\d\+\).\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkSection "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*节.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkSubsection "^\s*\zs\([零一二三四五六七八九十百千万]\+\)、.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkItem "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*条.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkSubsection "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*小节\?.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkNumItem "^\s*\zs\(\d\+\.\)\+.\{-}\ze\([.⋯\s/／]*-\?\d\+\s*\)$"
syntax match BookmarkPageNumber "\(\s\|[.⋯/／]\)*\zs-\?\d\+\ze\s*$"
syntax match LinesLackingPageNumber "^\s*\zs.*\D\+$"
syntax match TypoWhiteSpace "\(^\|\t\)\zs[ 　]\+"
syntax match TypoWhiteSpace "[ 　]\+\ze\t" " 正则似乎并没有问题，但是不能正常高亮制表符前的空格符号

" 定义颜色方案（基于Monokai配色方案）
highlight NonMain                             ctermfg=208        guifg=#FD971F " Monokai橙色
highlight BookmarkPart                        ctermfg=2          guifg=#A6E22E " 鲜绿
highlight BookmarkSubpart                     ctermfg=10         guifg=#00FFFF " 亮青
highlight BookmarkChapter                     ctermfg=17         guifg=#4184F3 " 亮蓝
highlight BookmarkSection                     ctermfg=14         guifg=#89BD55 " 暗绿
highlight BookmarkSubsection                  ctermfg=13         guifg=#DDA0DD " 浅紫
highlight BookmarkItem                        ctermfg=3          guifg=#E6DB74 " 黄色
highlight BookmarkNumItem                     ctermfg=1          guifg=#F92672 " 暗红
" highlight link                                BookmarkPageNumber Number
highlight BookmarkPageNumber ctermfg=5 guifg=#FF55FF " 亮紫/粉色
highlight LinesLackingPageNumber              ctermbg=red        guibg=red " 红色
highlight TypoWhiteSpace ctermbg=DarkRed guibg=DarkRed " 暗红

let b:current_syntax = "bookmark"
