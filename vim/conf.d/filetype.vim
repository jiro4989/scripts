" 拡張子マッピング
au BufNewFile,BufRead *.kt setlocal filetype=kotlin
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
au BufRead,BufNewFile *.{bl,backlog} setlocal filetype=backlog

" 新規ファイルを開いた時にテンプレートを読み込む
" TODO: ここのテンプレート指定がいけてない
au BufNewFile *.py 0r        $HOME/.vim/template/python.txt
au BufNewFile *.java 0r      $HOME/.vim/template/java.txt
au BufNewFile *.sh,*.bash 0r $HOME/.vim/template/bash.txt

" ファイル内に複数の拡張子が登場するときのシンタックス判定の範囲設定
autocmd FileType jsp,asp,php,xml,perl,html,javascript,css syntax sync minlines=500 maxlines=1000
