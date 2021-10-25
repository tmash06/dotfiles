"---------------------------------------------------------------------------
" dein:
"

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim


if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('vim-scripts/gtags.vim')
  call dein#add('vim-scripts/tComment')
  call dein#add('vim-scripts/smartchr')
  call dein#add('vim-scripts/a.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('haya14busa/incsearch.vim')


  call dein#add('Shougo/denite.nvim')

  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

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
set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4
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
" unite (ripgrep)
"
if executable('rg')
  let g:unite_source_grep_command = 'rg'
  let g:unite_source_grep_default_opts = '-n --no-heading --color never'
  let g:unite_source_grep_recursive_opt = ''
  " Hit件数制御したいなら以下
  let g:unite_source_grep_max_candidates = 200
  " Windowsなら
  let g:unite_source_grep_encoding='utf-8'
endif

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

"---------------------------------------------------------------------------
" vim-altr
"
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
