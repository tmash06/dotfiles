" Vundleの読み込み
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle管理のプラグイン
Bundle 'gmarik/vundle'
"Bundle 'rails.vim'
Bundle 'smartchr'
Bundle 'tComment'
Bundle 'Toggle'
Bundle 'EasyMotion'
Bundle 'abolish.vim'
Bundle 'Shougo/unite.vim'
Bundle 'errormarker.vim'
Bundle 'matchit.zip'
Bundle 'TwitVim'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-quickrun'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete.git' 
Bundle 'Changed'
Bundle 'tyru/open-browser.vim'
Bundle 'YankRing.vim'

Bundle 'DirDiff.vim'
Bundle 'scrooloose/syntastic'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'ujihisa/unite-font'

Bundle 'vim-scripts/Lucius'
Bundle 'h1mesuke/unite-outline'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'

" neocomplcache-snippets-complete.git
" snippetの配置場所
let g:neocomplcache_snippets_dir='~/.vim/snippets'

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

" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
"nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
"inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
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

" twitvim
let twitvim_count = 40
" nnoremap ,tp :<C-u>PosttoTwitter<CR>
" nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
" nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
" nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
" nnoremap ,tn :<C-u>NextTwitter<CR>

autocmd FileType twitvim call s:twitvim_my_settings()
function! s:twitvim_my_settings()
  set nowrap
endfunction

"
filetype plugin indent on

" タブの動作設定
set smarttab
set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4

" カラースキーマ
colorscheme desert

" 行番号表示
set number

" 編集中の行を強調表示する
set cursorline

" 入力中のコマンドを右下に表示する
set showcmd

" スワップファイル用ディレクトリを指定 
set directory=$HOME/.vimbackup

" 最後まで検索したら先頭に戻る
set wrapscan

" 既に他のウィンドウで開いているファイルを開かない
" MEMO:定義済みってエラーが出た
" runtime macros/editexisting.vim

" 変更中のファイルでも、保存せずに他のファイルを開けるようにする
set hidden

" Renameコマンド用 
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

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
