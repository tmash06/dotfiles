" dotfiles
if filereadable(expand('~/dotfiles/vim/.vimrc'))
    source ~/dotfiles/vim/.vimrc
endif

" local
if filereadable(expand('~/.vimrc.local'))
    source ~/dotfiles/vim/.vimrc.local
endif
