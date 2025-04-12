" Vim ftplugin file
" Language:	bookmark
" Maintainer: Lin Kun <Kun.Lin # qq.com>
" Last Change: 2024 Feb 20

augroup filetype_bookmark
    autocmd!
    " autocmd FileType bookmark setlocal noexpandtab
    " 上面这行配置会被覆盖，因而不够可靠使用下面这行更晚的事件来触发 setlocal noexpandtab，从而避免被覆盖
    autocmd VimEnter,BufEnter *.bookmark setlocal noexpandtab
    autocmd BufWritePre,FileWritePre *.bookmark FormatBookmark
augroup END

command! -nargs=0 -range=% StructureContentText2Bookmark :<line1>,<line2>call bookmark#StructureContentText2Bookmark()
command! -nargs=0 FormatBookmark : <line1>,<line2>call bookmark#FormatBookmark()
nnoremap <silent> <Plug>StructureContentText2Bookmark    :StructureContentText2Bookmark<cr>
nnoremap <silent> <Plug>FormatBookmark    :FormatBookmark<cr>

command! -nargs=0 CheckBookmark :call bookmark#CheckBookmark()

" 映射快捷键，这里使用 gcn, gcm, gco, gci, gca
" nnoremap gcn :call bookmark#CopyPageNumber('normal')<CR>
" nnoremap gcm :call bookmark#CopyPageNumber('minus_one')<CR>
" nnoremap gco :call bookmark#CopyPageNumber('last_odd')<CR>
" nnoremap gci :call bookmark#CopyPageNumber('increase_one')<CR>
" nnoremap gca :call bookmark#CopyPageNumber('next_odd')<CR>
