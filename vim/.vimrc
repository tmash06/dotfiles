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
  call dein#add('Shougo/defx.nvim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neco-syntax')
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('kana/vim-altr')
  call dein#add('mattn/vim-findroot')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-scripts/gtags.vim')
  call dein#add('vim-scripts/smartchr')
  call dein#add('vim-scripts/tComment')
  call dein#add('tmash06/vim-fubitive')
  call dein#add('tpope/vim-rhubarb')
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
  execute '!mkdir ' s:dotvim_dir
endif

let s:swapfiles_dir = expand('~/.vim/swapfiles')
let s:backups_dir = expand('~/.vim/backups')

if !isdirectory(s:swapfiles_dir)
  execute '!mkdir ' s:swapfiles_dir
endif

if !isdirectory(s:backups_dir)
  execute '!mkdir ' s:backups_dir
endif

let &directory=s:swapfiles_dir
let &backupdir=s:backups_dir

"---------------------------------------------------------------------------
" bell:
"

set belloff=all

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
" vim-altr

command! A call altr#forward()
call altr#remove_all()
call altr#define('%.h', '%.c', '%.cpp')

"---------------------------------------------------------------------------
" denite:
"

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort

  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')

  nnoremap <silent><buffer><expr> c
  \ denite#do_map('choose_action')

  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')

  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')

  nnoremap <silent><buffer><expr> J
  \ 'j'.denite#do_map('do_action', 'preview')

  nnoremap <silent><buffer><expr> K
  \ 'k'.denite#do_map('do_action', 'preview')

  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')

  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')

  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select')

  nnoremap <silent><buffer><expr> <C-w>
  \ denite#do_map('move_up_path')


endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    inoremap <silent><buffer><expr> <C-w>
    \ denite#do_map('move_up_path')
endfunction

nnoremap <silent> <C-d><C-d><C-f> :<C-u>DeniteBufferDir -buffer-name=files file file:new<CR>
nnoremap <silent> <C-d><C-d><C-b> :<C-u>Denite buffer<CR>
nnoremap <silent> <C-d><C-d><C-r> :<C-u>Denite -buffer-name=register register<CR>
nnoremap <silent> <C-d><C-d><C-o> :<C-u>Denite outline<CR>
nnoremap <silent> <C-d><C-d><C-e> :<C-u>Denite -resume<CR>
nnoremap <silent> <C-d><C-d><C-m> :<C-u>Denite file_mru -matchers='matcher_project_files,matcher_fuzzy'<CR>
nnoremap <silent> <C-d><C-d><C-a> :<C-u>Denite file_mru -matchers='matcher_fuzzy'<CR>

call denite#custom#option('default', {
    \ 'preview_height': 30,
    \ })

"---------------------------------------------------------------------------
" denite (ripgrep):
"

call denite#custom#var('grep', {
    \ 'command': ['rg'],
    \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
    \ 'recursive_opts': [],
    \ 'pattern_opt': ['--regexp'],
    \ 'separator': ['--'],
    \ 'final_opts': [],
    \ })

"---------------------------------------------------------------------------
" denite (menu):
"

let s:menus = g:local_denite_menus

let s:menus.my_commands = {
    \ 'description': 'Example commands'
    \ }

let s:menus.my_commands.command_candidates = [
    \ ['Split the window', 'vnew'],
    \ ['Split the window', 'vnew'],
    \ ['Split the window', '!start http://yahoo.co.jp'],
    \ ]


call denite#custom#var('menu', 'menus', s:menus)

"---------------------------------------------------------------------------
" defx:
"

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> E
    \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
    \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> O
    \ defx#do_action('open_tree', ['toggle', 'recursive:5'])
    nnoremap <silent><buffer><expr> o
    \ defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> K
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
    \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
    \ defx#do_action('toggle_columns',
    \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
    \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
    \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
    \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
    \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
endfunction

nnoremap <silent> <C-d><C-f><C-h> :<C-u>Defx -new `expand('%:h:p')` -split=vertical<CR>
nnoremap <silent> <C-d><C-f><C-r> :<C-u>Defx -resume -split=vertical<CR>


"---------------------------------------------------------------------------
" deoplete:
"

let g:deoplete#enable_at_startup = 1

"---------------------------------------------------------------------------
" neosnippet:
"

let g:neosnippet#disable_runtime_snippets = {
    \ 'c'   : 1,
    \ 'cpp' : 1,
    \ }

let g:neosnippet#snippets_directory = [ 
    \   '~/dotfiles/vim/snippets/' 
    \ ]

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
