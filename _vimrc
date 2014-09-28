if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

set hidden

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

filetype plugin indent on
NeoBundleCheck

" Plugins managed by NeoBundle
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'smartchr'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'a.vim'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'Toggle'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'thinca/vim-quickrun', {
            \ 'depends' : 'mattn/quickrunex-vim',
            \ }
" NeoBundleLazy 'rhysd/vim-clang-format', {
"            \ 'autoload' : {'filetypes' : ['c', 'cpp', 'objc']}
"            \ }
NeoBundle 'tComment'

" Unite.vim
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

" ESC by C-j
imap <C-j>  <ESC>

" 範囲選択インデントを連続して変更出来るようにする
vnoremap < <gv
vnoremap > >gv

" smartchr
autocmd FileType c,cpp inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=', '==')
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#one_of('.', '->', '...')
autocmd FileType c,cpp inoremap <buffer> <expr> , smartchr#one_of(', ', ',')

syntax on

" Tab
set smarttab
set softtabstop=2
set tabstop=4
set expandtab
set shiftwidth=2
set shiftround
set cindent

" Display
set number
set cursorline
set showcmd
set nowrap
" Color scheme
colorscheme desert

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

" Search
set wrapscan
set ignorecase
set smartcase
set hlsearch

" Dirs
set directory=$HOME/.vim/swapfiles
set backupdir=$HOME/.vim/backups

" Change active window by CTRL-hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" NeoSnippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Include file searching paths
set path+=,,./../include,./../../include,./../../../include,./../../../../include

" Tag file searching paths
set tags=./tags;,tags;

" gtags
nnoremap <C-g><C-j> :GtagsCursor<CR>
nnoremap <C-g><C-g> :Gtags 
nnoremap <C-g><C-p> :cp<CR>
nnoremap <C-g><C-n> :cn<CR>

"gitv
autocmd FileType git :setlocal foldlevel=99

" quickrun
nnoremap <C-q><C-q> :QuickRun<CR>
let g:quickrun_config = {
            \ "cpp/g++" : {
            \ 'command' : 'clang++',
            \ 'cmdopt' : '-std=c++1y -Wall -Wextra',
            \ 'hook/quickrunex/enable' : 1,
            \ }
          \ }
" yacc 
au BufNewFile,BufRead *.y setf cpp
