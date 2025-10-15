PREFIX=${HOME}
PWD = $(shell pwd)

.PHONY: all
all: helix tmux hyprland mc vim i3status mc


.PHONY: deps
deps:
	sudo pacman --noconfirm -S base-devel tmux helix neovim foot bemenu j4-dmenu-desktop i3status slurp grim wl-clipboard mc

.PHONY: keyboard
keyboard:
	keyboard/install.sh


.PHONY: zsh
zsh: ${PREFIX}/.zshrc.local

${PREFIX}/.zshrc.local:
	ln -s -f ${PWD}/zsh/zshrc.local ${PREFIX}/.zshrc.local


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


.PHONY: helix
helix: ${PREFIX}/.config/helix/config.toml

${PREFIX}/.config/helix/config.toml:
	mkdir -p ${PREFIX}/.config/helix
	ln -s -f ${PWD}/helix/config.toml ${PREFIX}/.config/helix/config.toml


.PHONY: mc
mc: ${PREFIX}/.config/mc/ini

${PREFIX}/.config/mc/ini:
	mkdir -p ${PREFIX}/.config/mc
	ln -s -f ${PWD}/mc/ini ${PREFIX}/.config/mc/ini


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
	sudo pacman --noconfirm -S brightnessctl hyprland kitty mako nerd-fonts waybar wofi xdg-desktop-portal-wlr
	mkdir -p ${PREFIX}/.config/hypr
	ln -s -f ${PWD}/hyprland/hyprland.conf ${PREFIX}/.config/hypr/hyprland.conf
	ln -s -f ${PWD}/waybar ${PREFIX}/.config/waybar

