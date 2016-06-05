if &compatible
  set nocompatible
endif

"---------------------------------------------------------------------------
" dein:
"

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)
let s:toml      = '~/dotfiles/vim/dein.toml'
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#end()

if dein#check_install()
  if dein#check_install(['vimproc'])
    call dein#install(['vimproc'])
  endif

  call dein#install()
endif

"---------------------------------------------------------------------------
" directory:
"

let s:dotvim_dir = expand('~/.vim')
if !isdirectory(s:dotvim_dir)
  execute '!mkdir -p' s:dotvim_dir
endif

let s:swapfiles_dir = expand('~/.vim/swapfiles')
let s:backups_dir = expand('~/.vim/backups')

if !isdirectory(s:swapfiles_dir)
  execute '!mkdir -p' s:swapfiles_dir
endif

if !isdirectory(s:backups_dir)
  execute '!mkdir -p' s:backups_dir
endif

let &directory=s:swapfiles_dir
let &backupdir=s:backups_dir

"---------------------------------------------------------------------------
" edit:
"

" 範囲選択インデントを連続して変更出来るようにする
vnoremap < <gv
vnoremap > >gv

"---------------------------------------------------------------------------
" tab & indent:
"

set smarttab
set softtabstop=2
set tabstop=4
set expandtab
set shiftwidth=2
set shiftround
set cindent

"---------------------------------------------------------------------------
" status line:
"

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

"---------------------------------------------------------------------------
" display:
"

set number
set cursorline
set showcmd
set nowrap
set laststatus=2
set title
syntax on

"---------------------------------------------------------------------------
" search:
"

set wrapscan
set ignorecase
set smartcase
set hlsearch

"---------------------------------------------------------------------------
" window:
"

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"---------------------------------------------------------------------------
" neosnippet:
"

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"---------------------------------------------------------------------------
" vim-clang:
"

let g:clang_auto = 0 
let g:clang_c_completeopt = 'menuone,preview' 
let g:clang_cpp_completeopt = 'menuone,preview' 

"---------------------------------------------------------------------------
" neocomplete:
"

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

"---------------------------------------------------------------------------
" unite:
"

nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> ,uo :<C-u>Unite outline<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " Leave unite window by pressing ESC 2 times.
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

"---------------------------------------------------------------------------
" smartchr:
"

autocmd FileType c,cpp inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=', '==')
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#one_of('.', '->', '...')
autocmd FileType c,cpp inoremap <buffer> <expr> , smartchr#one_of(', ', ',')

"---------------------------------------------------------------------------
" incsearch:
"
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


"---------------------------------------------------------------------------
" switch
"
let g:switch_mapping = "+"

"---------------------------------------------------------------------------
" vim-altr
"

command! A call altr#forward()
