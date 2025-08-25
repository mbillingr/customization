
guix shell \
  --container --emulate-fhs --network \
  --preserve='.*' \
  --preserve='^DBUS_' --expose=/var/run/dbus \
  --preserve='^XDG_|^WAYLAND_DISPLAY$' --expose=/run/user \
  --preserve='^DISPLAY$' --expose=/dev/dri --expose=/sys/dev --expose=/sys/devices \
  --share=$HOME \
  coreutils curl gcc-toolchain grep libxkbcommon nss-certs wayland xdg-utils xdg-user-dirs zsh \
  mesa-utils zlib \
  --
