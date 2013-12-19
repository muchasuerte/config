#!/bin/bash
# kate: indent-width 4; remove-trailing-spaces none; replace-tabs true; tab-indents false; tab-width 4;
#

if [ -e "$HOME/.vim" ]; then
    BACKUP="$HOME/.vim.$(date +%s).orig"
    echo "make BACKUP of original .vim dir to $BACKUP"
    mv "$HOME/.vim" $BACKUP
fi

if [ -e "$HOME/.vimrc" ]; then
    BACKUP="$HOME/.vimrc.$(date +%s).orig"
    echo "make BACKUP of original .vim dir to $BACKUP"
    mv "$HOME/.vimrc" $BACKUP
fi

ln -s $(readlink -f ./_vim) ~/.vim
ln -s $(readlink -f ./vimrc) ~/.vimrc

rm -rf $HOME/.vim/bundle
mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if [ "x$?" == "x0" ]; then
    echo "BundleInstall..."
    vim -u $HOME/.vim/bundles.vim +BundleInstall +q
fi
