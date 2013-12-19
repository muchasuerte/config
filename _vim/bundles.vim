set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
" fugitive vim plugin for git
Bundle 'tpope/vim-fugitive'

" ...rest of bundles
Bundle 'fholgado/minibufexpl.vim'

Bundle 'scrooloose/nerdtree'

" A code-completion engine for Vim:
" require plugin build:
" 	~/.vim/bundle/YouCompleteMe$ ./install.sh --clang-completer
" 	fix for ubuntu : sudo ln -s /usr/lib/llvm-3.4/lib /usr/lib/llvm
" 	sudo apt-get install libclang-3.4-dev
" 	./install.sh --clang-completer --system-libclang
Bundle 'Valloric/YouCompleteMe'

"  Syntax checking hacks for vim
Bundle 'scrooloose/syntastic'

" A forked script for vim auto reloading of buffers when changed on disk.
Bundle 'mutewinter/vim-autoreadwatch'

" Bundle "pangloss/vim-javascript"

" Extended session management for Vim (:mksession on steroids)
Bundle 'vim-misc'
Bundle 'xolox/vim-session'
