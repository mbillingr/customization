#! /bin/bash
set -e

WORKDIR=`pwd`
PREFIX=~


echo "Installing Oh-my-tmux..."
cd $PREFIX
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

echo "Installing Vim stuff..."
mkdir -p $PREFIX/.vim/colors
curl https://raw.githubusercontent.com/doums/darcula/master/colors/darcula.vim -o $PREFIX/.vim/colors/darcula.vim

echo "Setting up symlinks..."
ln -s -f $WORKDIR/tmux/tmux.conf.local $PREFIX/.tmux.conf.local
ln -s -f $WORKDIR/vim/vimrc $PREFIX/.vimrc

