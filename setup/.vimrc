" pre.local
if filereadable(expand('~/.vimrc.pre.local'))
    source ~/.vimrc.pre.local
endif

" dotfiles
if filereadable(expand('~/dotfiles/vim/.vimrc'))
    source ~/dotfiles/vim/.vimrc
endif

" local
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
