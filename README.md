# BookmarkEditor.vim
此插件用于将目录文本结构化，以便使用PdgCntEditor给PDF批量添加书签。

包括两个自定义命令：`StructureContentText2Bookmark`和`FormatBookmark`。

`StructureContentText2Bookmark`用于给部、章、节标题行添加适当的缩进，删除汉字间的空白，并将章节标题与页码之间的字符替换为一个制表符。还能够修复OCR出的目录文本中常有的全、半角圆括号配对的情况。

`FormatBookmark`用于将4个空格替换为一个制表符。

此插件能够高亮封面、目录、部、章、节等标题，并能够高亮显示末尾没有页码的行，从而方便编辑目录文本。
