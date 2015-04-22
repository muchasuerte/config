set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
" fugitive vim plugin for git
Plugin 'tpope/vim-fugitive'

" ...rest of Plugins
Plugin 'fholgado/minibufexpl.vim'

Plugin 'scrooloose/nerdtree'

" A code-completion engine for Vim:
" require plugin build:
" 	~/.vim/Plugin/YouCompleteMe$ ./install.sh --clang-completer
" 	fix for ubuntu : sudo ln -s /usr/lib/llvm-3.4/lib /usr/lib/llvm
" 	sudo apt-get install libclang-3.4-dev
" 	./install.sh --clang-completer --system-libclang
Plugin 'Valloric/YouCompleteMe'

"  Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'

" A forked script for vim auto reloading of buffers when changed on disk.
Plugin 'mutewinter/vim-autoreadwatch'

" Plugin "pangloss/vim-javascript"

" Extended session management for Vim (:mksession on steroids)
Plugin 'vim-misc'
Plugin 'xolox/vim-session'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'

call vundle#end()            " required
filetype plugin indent on    " required

