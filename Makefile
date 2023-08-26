PREFIX=${HOME}
PWD = $(shell pwd)

.PHONY: all
all: tmux sway vim


.PHONY: deps
deps:
	sudo pacman -S neovim tmux sway foot bemenu i3status

.PHONY: keyboard
keyboard:
	keyboard/install.sh


.PHONY: tmux
tmux: ${PREFIX}/.tmux.conf ${PREFIX}/.tmux.conf.local

${PREFIX}/.tmux:
	git clone https://github.com/gpakosz/.tmux.git ${PREFIX}/.tmux

${PREFIX}/.tmux.conf: ${PREFIX}/.tmux
	ln -s -f ${PREFIX}/.tmux/.tmux.conf ${PREFIX}/.tmux.conf

${PREFIX}/.tmux.conf.local:
	ln -s -f ${PWD}/tmux/tmux.conf.local ${PREFIX}/.tmux.conf.local


.PHONY: sway
sway:  ${PREFIX}/.config/sway/config

${PREFIX}/.config/sway/config:
	mkdir -p ${PREFIX}/.config/sway
	ln -s -f ${PWD}/sway/config ${PREFIX}/.config/sway/config


.PHONY: vim
vim: ${PREFIX}/.vim/colors/darcula.vim ${PREFIX}/.config/nvim ${PREFIX}/.vimrc

${PREFIX}/.vim/colors:
	mkdir -p ${PREFIX}/.vim/colors

${PREFIX}/.vim/colors/darcula.vim: ${PREFIX}/.vim/colors
	curl https://raw.githubusercontent.com/doums/darcula/master/colors/darcula.vim -o ${PREFIX}/.vim/colors/darcula.vim

${PREFIX}/.config/nvim: ${PREFIX}/.vim/colors
	mkdir -p ${PREFIX}/.config/nvim
	ln -s -f ${PREFIX}/.vim/colors ${PREFIX}/.config/nvim/colors
	ln -s -f ${PWD}/vim/vimrc ${PREFIX}/.config/nvim/init.vim

${PREFIX}/.vimrc:
	ln -s -f ${PWD}/vim/vimrc ${PREFIX}/.vimrc
