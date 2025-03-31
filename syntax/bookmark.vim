" Vim syntax file
" Language:	bookmark
" Maintainer:	Lin Kun <Kun.Lin # qq.com>
" Last Change:	2024 Feb 20


if exists("b:current_syntax")
  finish
endif

syntax clear

" 定义书签不同层级的正则表达式匹配规则，同时匹配带坐标和不带坐标的页码
syntax match NonMain "^\s*\zs\(扉页\|跋\)\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(封皮\|封面\|书名\|版权\(信息\)\?\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\([总分]\?目录\|简目\|详目\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(\d\{4}\s*年\?版\?\)\?\([前自再代总]序\|[前导弁引]言\|序[文言]\?\|代总序\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(绪论\|使用指南\|编者的话\|摘要\|内容摘要\|关键词\|缩略语\|术语表\|法律声明\|读者对象\|注释\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(作者简介\|关于作者\|作者\|编委会\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(附则\|索引\|后\?附录\|结语\|后[记序题]\|封底\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(主要\)\?\(参考\(文献\|书目\)\)页\?\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match NonMain "^\s*\zs\(第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*版\)\(前言\|序言\?\)\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkPart "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*\(部分\?\|卷\).\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkSubpart "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*分\?编.\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkSubpart "^\s*\zs[上中下]篇.\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkChapter "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*\([章讲回]\|单元\).\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkSection "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*节.\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkSubsection "^\s*\zs\([零一二三四五六七八九十百千万]\+\)、.\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
syntax match BookmarkItem "^\s*\zs第\s*\([零一二三四五六七八九十百千万]\+\|\d\+\)\s*条.\{-}\ze\(\(\s\|[.⋯/／]\)*-\?\d\+\(\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\)\?\)$"
" 匹配带坐标的页码
syntax match BookmarkPageWithCoords "-\?\d\+\s\/XYZ\(\s\d\+\(\.\d\+\)\?\)\{3}$" contains=BookmarkPageNumberWithCoord,BookmarkPageXCoord,BookmarkPageYCoord,BookmarkPageZCoord
" 匹配页码
syntax match BookmarkPageNumberWithCoord "-\?\d\+\ze\s\/XYZ\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?$" contained
" 匹配XYZ坐标中的X部分
syntax match BookmarkPageXCoord "\/XYZ\s\zs\d\+\(\.\d\+\)\?\ze\s\d\+\(\.\d\+\)\?\s\d\+\(\.\d\+\)\?$" contained nextgroup=BookmarkPageYCoord skipwhite
" 匹配XYZ坐标中的Y部分
syntax match BookmarkPageYCoord "\d\+\(\.\d\+\)\?\ze\s\d\+\(\.\d\+\)\?$" contained nextgroup=BookmarkPageZCoord skipwhite
" 匹配XYZ坐标中的Z部分
syntax match BookmarkPageZCoord "\d\+\(\.\d\+\)\?$" contained

" 修改后的页码匹配，避免匹配到带坐标的格式
syntax match BookmarkPageNumberWithoutCoord "\(\s\|[.⋯/／]\)*\zs-\?\d\+\ze\s*$"

syntax match LinesLackingPageNumber '\v\s*\zs(-?\D+)\ze(\s?/XYZ(\s\d+(\.\d+)?){3})?\s*$'
syntax match LinesHavingOnlyPageNumber '\v^\s*\zs(-?\d+)\ze(\s?/XYZ(\s\d+(\.\d+)?){3})?\s*$'

syntax match TypoWhiteSpace "\(^\|\t\)\zs[ 　]\+"
syntax match TypoWhiteSpace "[ 　]\+\ze\t" " 正则似乎并没有问题，但是不能正常高亮制表符前的空格符号

"         定义颜色方案（基于Monokai配色方案）
highlight NonMain                             ctermfg=208     guifg=#FD971F      "      Monokai橙色
highlight BookmarkPart                        ctermfg=2       guifg=#A6E22E      "      鲜绿
highlight BookmarkSubpart                     ctermfg=10      guifg=#00FFFF      "      亮青
highlight BookmarkChapter                     ctermfg=17      guifg=#4184F3      "      亮蓝
highlight BookmarkSection                     ctermfg=14      guifg=#89BD55      "      暗绿
highlight BookmarkSubsection                  ctermfg=13      guifg=#DDA0DD      "      浅紫
highlight BookmarkItem                        ctermfg=3       guifg=#E6DB74      "      黄色
highlight BookmarkNumItem                     ctermfg=1       guifg=#F92672      "      暗红
"         highlight                           link            BookmarkPageNumber Number
highlight BookmarkPageNumberWithCoord         ctermfg=5       guifg=#FF55FF      "      亮紫/粉色
highlight BookmarkPageNumberWithoutCoord      ctermfg=5       guifg=#FF55FF      "      亮紫/粉色
"         高亮X坐标
highlight BookmarkPageXCoord                  ctermfg=9       guifg=#FF6347      "      番茄色
"         高亮Y坐标
highlight BookmarkPageYCoord                  ctermfg=11      guifg=#FFD700      "      金色
"         高亮Z坐标
highlight BookmarkPageZCoord                  ctermfg=14      guifg=#00BFFF      "      深天蓝色
highlight LinesLackingPageNumber              ctermbg=red     guibg=red          "      红色
highlight LinesHavingOnlyPageNumber           ctermbg=red     guibg=red          "      红色
highlight TypoWhiteSpace                      ctermbg=DarkRed guibg=DarkRed      "      暗红

let b:current_syntax = "bookmark"
