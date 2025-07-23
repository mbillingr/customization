;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (guix git-download)
             (gnu home services)
             (gnu home services shells))

;; note: perl is needed for oh-my-tmux
(define EVERYDAY-CLI-PACKAGES
  '("helix" "git" "perl" "tmux"))

(define HYPRLAND-PACKAGES
  '("brightnessctl" "kitty" "mako" "waybar" "wofi" "xdg-desktop-portal-wlr"))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages 
              (append EVERYDAY-CLI-PACKAGES
                      HYPRLAND-PACKAGES)))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (append (list (service home-zsh-service-type
                          (home-zsh-configuration
                            (zshrc (list (local-file "../3rd-party/zsh/zshrc")
                                         (local-file "../files/zshrc.local")))))
                 (service home-bash-service-type
                          (home-bash-configuration
                           (aliases '(("grep" . "grep --color=auto")
                                      ("ll" . "ls -l")
                                      ("ls" . "ls -p --color=auto")))
                           (bashrc (list (local-file
                                          "bashrc")))
                           (bash-profile (list (local-file
                                                "bash_profile")))))
                 (simple-service 'test-config
                                 home-xdg-configuration-files-service-type
                                 (list `("helix/config.toml" ,(local-file "../files/helix-config.toml"))
                                       `("hypr/hyprland.conf" ,(local-file "../files/hyprland.conf"))
                                       `("tmux/tmux.conf" ,(local-file "../3rd-party/tmux/.tmux.conf" "tmux.conf"))
                                       `("tmux/tmux.conf.local" ,(local-file "../files/tmux.conf.local"))
                                       `("waybar/config.jsonc" ,(local-file "../files/waybar-config.jsonc"))
                                       `("waybar/style.css" ,(local-file "../files/waybar-style.css"))
                                 )))
           %base-home-services)))
