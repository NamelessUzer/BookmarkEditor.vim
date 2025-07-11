# BookmarkEditor.vim

此插件用于将目录文本结构化，以便使用 PdgCntEditor 给 PDF 批量添加书签。

包括三个自定义命令：`StructureContentText2Bookmark`、`FormatBookmark`和`CheckBookmark`。

`StructureContentText2Bookmark`用于给部、章、节标题行添加适当的缩进，删除汉字间的空白，并将章节标题与页码之间的字符替换为一个制表符。还能够修复 OCR 出的目录文本中常有的全、半角圆括号配对的情况。

`FormatBookmark`可格式化目录文件，它可以改正一些常见的错误，例如，将 4 个空格替换为一个制表符，通常不需要运行，该命令会在文档保存时自动运行。

`CheckBookmark`可检查目录中的错误，并将错误在 QuickFix 窗口中列出，从而可以快速定位错误。

此插件能够高亮封面、目录、部、章、节等标题，并能够高亮显示末尾没有页码的行，从而方便编辑目录文本。

## 安装

使用你最喜欢的插件管理器。

使用 [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'NamelessUzer/BookmarkEditor.vim'
```

## 使用

将从 PDF 文档中复制到的目录复制到一个空白的 bookmark 文档(\*.bookmark)中并保存，并使用 Vim 或 Neovim 打开该文档。

运行如下命令
`:StructureContentText2Bookmark`
即可初步格式化目录文件，然后再手工修改文档中不合理或错误之处。

运行如下命令
`:FormatBookmark`
即可格式化目录文件，它可以改正一些常见的错误，例如，将 4 个空格替换为一个制表符，通常不需要运行，该命令会在文档保存时自动运行。

运行如下命令
`:CheckBookmark`
即可将错误在 QuickFix 窗口中列出，从而可以快速定位错误，目前只能检查一种错误，检查并定位缺少页码的行。

您也可以将上述命令映射为您喜欢的快捷键，方便快捷操作，例如：

```VimScript
nnoremap <localleader>bs <Plug>(StructureContentText2Bookmark)
nnoremap <localleader>bf <Plug>(FormatBookmark)
nnoremap <localleader>bc <Plug>(CheckBookmark)
```

PDF 的目录中，有时章、节标题后会不带页码，它们的页码通常是随后一个书签中的页码，或者随后一个书签行所指向的页码的前一页，或者随后一个书签行所指向的页码的前一个奇数页。
可以通过映射快捷键的方式解决，这里使用 gcn, gcm, gco 三个快捷键：

```VimScript
nnoremap gcn <Plug>(BookmarkCopyNormal)
" gcn 用于拷贝下一行中的页码并粘贴至当前行（适用于 normal 模式）

nnoremap gcm <Plug>(BookmarkCopyMinusOne)
" gcm 用于拷贝下一行中的页码并减 1 后粘贴到当前行（minusOne 模式）

nnoremap gco <Plug>(BookmarkCopyLastOdd)
" gco 用于将下一行的页码计算前一个奇数页码后粘贴到当前行（lastOdd 模式）

nnoremap gci <Plug>(BookmarkCopyIncreaseOne)
" gci 用于拷贝上一行中的页码并加 1 后粘贴到当前行（increaseOne 模式）

nnoremap gca <Plug>(BookmarkCopyNextOdd)
" gca 用于将上一行的页码计算后一个奇数页码后粘贴到当前行（nextOdd 模式）
```

前述五个快捷键在粘贴页码到当前行时会先删除当前行已有的页码和坐标（若有）。
