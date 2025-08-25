;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(add-to-load-path (dirname (current-filename)))

(use-modules (guix gexp)
             (nonguix utils)
             (gnu home)
             (gnu packages)
             (gnu packages gl)
             (gnu services)
             (gnu home services)
             (gnu home services shells)
             (gnu home services syncthing)
             (nongnu packages nvidia))


;; note: perl is needed for oh-my-tmux
(define EVERYDAY-CLI-PACKAGES
  `("git" "helix" "jujutsu" "perl" "tmux"))

(define GUIX-HACKING-PACKAGES
  '("emacs" "guile" "emacs-geiser" "emacs-geiser-guile"))

(define EVERYDAY-GUI-PACKAGES
  '("flatpak" "icecat" "keepassxc"))

(define GPU_PACKAGES
  '("mesa-utils"))

(define HYPRLAND-PACKAGES
  '("brightnessctl" "kitty" "mako" "waybar" "wofi" "xdg-desktop-portal-wlr"))

(define (my-replace-mesa obj)
  (with-transformation
    (package-input-grafting
      `((,mesa . ,nvda)
        (,nvidia-driver . ,nvda)))
    obj))

(define (ensure-package pkg)
  (cond 
    ((string? pkg) (specification->package pkg))
    (else pkg)))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (append
              (map ensure-package
               (append GUIX-HACKING-PACKAGES
                       EVERYDAY-CLI-PACKAGES
                       EVERYDAY-GUI-PACKAGES
                       HYPRLAND-PACKAGES))
              (map my-replace-mesa (map ensure-package GPU_PACKAGES))))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (append (list (service home-zsh-service-type
                          (home-zsh-configuration
                            (environment-variables
                              '(("__NV_PRIME_RENDER_OFFLOAD" . "1")
                                ("__GLX_VENDOR_LIBRARY_NAME" . "nvidia")))
                            (zshrc (list (local-file "3rd-party/zsh/zshrc")
                                         (local-file "files/zshrc.local")))))
                 (service home-bash-service-type
                          (home-bash-configuration
                           (aliases '(("grep" . "grep --color=auto")
                                      ("ll" . "ls -l")
                                      ("ls" . "ls -p --color=auto")))
                           (bashrc (list (local-file
                                          "files/bashrc")))
                           (bash-profile (list (local-file
                                                "files/bash_profile")))))
                 (simple-service 'test-config
                                 home-xdg-configuration-files-service-type
                                 (list `("emacs/init.el" ,(local-file "files/emacs-init.el"))
                                       `("helix/config.toml" ,(local-file "files/helix-config.toml"))
                                       `("hypr/hyprland.conf" ,(local-file "files/hyprland.conf"))
                                       `("tmux/tmux.conf" ,(local-file "3rd-party/tmux/.tmux.conf" "tmux.conf"))
                                       `("tmux/tmux.conf.local" ,(local-file "files/tmux.conf.local"))
                                       `("waybar/config.jsonc" ,(local-file "files/waybar-config.jsonc"))
                                       `("waybar/style.css" ,(local-file "files/waybar-style.css"))))
                (service home-files-service-type
                         `((".local/bin/guix-guile"
                            ,(computed-file
                               "guix-guile"
                               (with-imported-modules
                                 '((guix build utils))
                                 #~(begin
                                     (use-modules (guix build utils))
                                     (copy-file #$(local-file "files/guix-guile") #$output)
                                     (chmod #$output #o555)))))))
                (service home-syncthing-service-type))
           %base-home-services)))
