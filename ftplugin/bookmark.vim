" Vim ftplugin file
" Language:	bookmark
" Maintainer: Lin Kun <Kun.Lin # qq.com>
" Last Change: 2025 May 20

augroup filetype_bookmark
    autocmd!
    " autocmd FileType bookmark setlocal noexpandtab
    " 上面这行配置会被覆盖，因而不够可靠使用下面这行更晚的事件来触发 setlocal noexpandtab，从而避免被覆盖
    autocmd VimEnter,BufEnter *.bookmark setlocal noexpandtab
    autocmd BufWritePre,FileWritePre *.bookmark FormatBookmark
augroup END


" 命令定义
command! -nargs=0 -range=% StructureContentText2Bookmark :<line1>,<line2>call bookmark#StructureContentText2Bookmark()
command! -nargs=0 FormatBookmark : <line1>,<line2>call bookmark#FormatBookmark()
command! -nargs=0 CheckBookmark :call bookmark#CheckBookmark()

" <Plug> 映射
nnoremap <silent> <Plug>(StructureContentText2Bookmark) :StructureContentText2Bookmark<cr>
nnoremap <silent> <Plug>(FormatBookmark)                :FormatBookmark<cr>
nnoremap <silent> <Plug>(CheckBookmark)                 :CheckBookmark<CR>
nnoremap <silent> <Plug>(BookmarkCopyNormal)            :call bookmark#CopyPageNumber('normal')<CR>
nnoremap <silent> <Plug>(BookmarkCopyMinusOne)          :call bookmark#CopyPageNumber('minusOne')<CR>
nnoremap <silent> <Plug>(BookmarkCopyLastOdd)           :call bookmark#CopyPageNumber('lastOdd')<CR>
nnoremap <silent> <Plug>(BookmarkCopyIncreaseOne)       :call bookmark#CopyPageNumber('increaseOne')<CR>
nnoremap <silent> <Plug>(BookmarkCopyNextOdd)           :call bookmark#CopyPageNumber('nextOdd')<CR>

" 映射快捷键（默认不启用，只供用户参考），这里使用 gcn, gcm, gco, gci, gca
" nnoremap gcn <Plug>(BookmarkCopyNormal)
" nnoremap gcm <Plug>(BookmarkCopyMinusOne)
" nnoremap gco <Plug>(BookmarkCopyLastOdd)
" nnoremap gci <Plug>(BookmarkCopyIncreaseOne)
" nnoremap gca <Plug>(BookmarkCopyNextOdd)
