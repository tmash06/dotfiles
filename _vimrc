" Vundleの読み込み
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle管理のプラグイン
Bundle 'gmarik/vundle'
Bundle 'smartchr'
Bundle 'tComment'
Bundle 'Toggle'
Bundle 'abolish.vim'
Bundle 'Shougo/unite.vim'
Bundle 'errormarker.vim'
Bundle 'matchit.zip'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-quickrun'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete.git'
Bundle 'Changed'
Bundle 'tyru/open-browser.vim'
Bundle 'tyru/restart.vim'
" キーバインドがNeoComplcacheとかぶったので、とりあえず無効化
" Bundle 'YankRing.vim'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/Lucius'
Bundle 'h1mesuke/unite-outline'
Bundle 'taglist.vim'
Bundle 'BufOnly.vim'
Bundle 'tpope/vim-fugitive.git'
Bundle 'scrooloose/nerdtree'
Bundle 'a.vim'
Bundle 'tagexplorer.vim'
Bundle 'Align'
Bundle 'mattn/webapi-vim'
Bundle 'thinca/vim-openbuf'
Bundle 'tsukkee/unite-tag'
Bundle 'Shougo/vimfiler'
Bundle 'ujihisa/neco-look'
Bundle 'trinity.vim'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'taku-o/vim-copypath'
Bundle 'Shougo/vinarise'
Bundle 'thinca/vim-ref'
Bundle 'gtags.vim'
Bundle 'Shougo/vimshell'

Bundle 'mattn/zencoding-vim'

"
nnoremap <silent> ,gg :<C-u>:CdCurrent<CR>:GtagsCursor<CR>
nnoremap <silent> ,gp :<C-u>:cn<CR>
nnoremap <silent> ,gn :<C-u>:cp<CR>

" 終了時に保存するセッションオプションを設定する
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

if has('mac')
 	set gfn=Ricty\ Regular:h14
 	set gfw=Ricty\ Regular:h14
endif
let g:ref_refe_cmd = "/Users/tmash06/dev/ruby/ref/refe-1_9_2"

" let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"experiment 2011.10.14
:function! NdkBuild()
    :CdCurrent
    :w
    :set makeprg=ndk-build
    :make
:endfunction

:nmap ,nb :call NdkBuild()<CR>


" 範囲選択インデントを連続して変更出来るようにする
vnoremap < <gv
vnoremap > >gv

" 他で書き換えられたら自動で読み直す
set autoread

" 挿入モードでCtrl+pを押すとクリップボードの内容を貼り付けられるようにする "
imap <C-p>  <ESC>"*pa

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" F2/S-F2でvimrcを表示/更新
nnoremap <silent> <F2> :<C-u>:e ~/.vimrc<CR>
nnoremap <silent> <S-F2> :<C-u>:source ~/.vimrc<CR>:echo 'reload .vimrc'<CR>

" C-mでSave & Make
nnoremap <silent> <C-m> :<C-u>:w<CR>:make<CR>

" 無限undo
if has('persistent_undo')
    set undodir=~/.vimundo
    set undofile
endif

" ステータスラインの表示
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
  set statusline+=%y    " バッファ内のファイルのタイプ
  set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%1l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=%c    " 何列目にカーソルがあるか
  set statusline+=%V    " 画面上の何列目にカーソルがあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%P    " ファイル内の何％の位置にあるか

" neocomplcache-snippets-complete.git {{{
    " snippetの配置場所
    let g:neocomplcache_snippets_dir='~/.vim/snippets'
" }}}

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" smartchr
autocmd FileType c,cpp inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=', '==')
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#one_of('.', '->', '...')
autocmd FileType c,cpp inoremap <buffer> <expr> , smartchr#one_of(', ', ',')

" Unite.vim
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" Bookmark
nnoremap <silent> ,uo :<C-u>Unite bookmark<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

" NeoComplCache
" 起動時から有効にする
let g:neocomplcache_enable_at_startup=1
" hoge_foo_barをhogefoobarから補完出来るようにする
let g:neocomplcache_enable_underbar_completion=1
" 大文字小文字無視
"let g:neocomplcache_ignore_case=1
" snippets展開
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" dicwin.vim
let plugin_dicwin_disable = 1

" twitvim
" let twitvim_count = 40 nnoremap ,tp :<C-u>PosttoTwitter<CR>
" " Friends TL
" nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
" " My TL
" nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
" " 自分へのリプライ
" nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
" " 次のページ
" nnoremap ,tn :<C-u>NextTwitter<CR>
" " testリスト
" nnoremap ,tlt :<C-u>ListTwitter test<CR>
"
" autocmd FileType twitvim call s:twitvim_my_settings()
" function! s:twitvim_my_settings()
"   " set nowrap
" endfunction

"
filetype plugin indent on

" タブの動作設定
set smarttab
set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4

" カラースキーマ
colorscheme lucius

" 行番号表示
set number

" 編集中の行を強調表示する
set cursorline

" 入力中のコマンドを右下に表示する
set showcmd

" スワップファイル用ディレクトリを指定
set directory=$HOME/.vimswap

" バックアップファイル用ディレクトリを設定
set backupdir=$HOME/.vimbackup

" 最後まで検索したら先頭に戻る
set wrapscan

" 既に他のウィンドウで開いているファイルを開かない
" MEMO:定義済みってエラーが出た
" runtime macros/editexisting.vim

" 変更中のファイルでも、保存せずに他のファイルを開けるようにする
set hidden

" Renameコマンド用
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" tCommentでC言語スタイルコメント
autocmd FileType c,cpp nnoremap <C-c><C-c> :TCommentAs c<CR>

"
" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにす
if exists('&ambiwidth')
  set ambiwidth=double
endif

" RVMで設定されたrubyをQuickrunで利用するため
set shell=/bin/bash\ -i
