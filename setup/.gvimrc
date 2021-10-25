" dotfiles
if filereadable(expand('~/dotfiles/vim/.gvimrc'))
    source ~/dotfiles/vim/.gvimrc
endif

" local 
if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif
