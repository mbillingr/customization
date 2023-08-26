#! /bin/bash
set -e

echo "======= WARNING ========"
echo "The install.sh script is deprecated. Use `make` instead."
echo "======= WARNING ========"

WORKDIR=`pwd`
PREFIX=~

sudo pacman -S neovim tmux sway foot bemenu i3status

#echo "Installing Oh-my-zsh..."
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing sway..."
mkdir -p $PREFIX/.config/sway
ln -s -f $WORKDIR/sway/config $PREFIX/.config/sway/config

echo "Installing Oh-my-tmux..."
cd $PREFIX
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

echo "Installing Vim stuff..."
mkdir -p $PREFIX/.vim/colors
mkdir -p $PREFIX/.config/nvim
curl https://raw.githubusercontent.com/doums/darcula/master/colors/darcula.vim -o $PREFIX/.vim/colors/darcula.vim

echo "Setting up symlinks..."
ln -s -f $WORKDIR/tmux/tmux.conf.local $PREFIX/.tmux.conf.local
ln -s -f $WORKDIR/vim/vimrc $PREFIX/.vimrc
ln -s -f $WORKDIR/vim/vimrc $PREFIX/.config/nvim/init.vim
ln -s -f $PREFIX/.vim/colors $PREFIX/.config/nvim/colors

echo "installing keyboard layout"
keyboard/install.sh

