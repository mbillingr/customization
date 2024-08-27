PREFIX=${HOME}
PWD = $(shell pwd)

.PHONY: all
all: tmux sway vim i3status


.PHONY: deps
deps:
	sudo pacman -S neovim tmux sway foot bemenu j4-dmenu-desktop i3status slurp grim wl-clipboard

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

.PHONY: i3status
sway:  ${PREFIX}/.i3status.conf

${PREFIX}/.i3status.conf:
	ln -s -f ${PWD}/i3status/i3status.conf ${PREFIX}/.i3status.conf

.PHONY: hyprland
hyprland:  ${PREFIX}/.config/hypr/hyprland.conf

${PREFIX}/.config/hypr/hyprland.conf:
	sudo pacman -S brightnessctl hyprland kitty mako otf-font-awesome ttf-meslo-nerd waybar wofi xdg-desktop-portal-wlr
	mkdir -p ${PREFIX}/.config/hypr
	ln -s -f ${PWD}/hyprland/hyprland.conf ${PREFIX}/.config/hypr/hyprland.conf
	ln -s -f ${PWD}/waybar ${PREFIX}/.config/waybar

