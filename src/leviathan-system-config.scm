;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (guix channels)
             (gnu)
             (gnu packages shells)
             (gnu packages package-management)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (nongnu services nvidia)
             (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)

(define SYSTEM-PACKAGES
  '("screen"))

(define HYPRLAND-PACKAGES
  '("hyprland" "kitty"))

(define CHANNELS
  (append
    (list (channel
            (name 'nonguix)
            (url "https://gitlab.com/nonguix/nonguix")
            (introduction
              (make-channel-introduction
                "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                (openpgp-fingerprint
                  "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))
    %default-channels))

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (kernel-arguments '("modprobe.blacklist=nouveau"
                      "nvidia_drm.modeset=1"))
  (locale "en_US.utf8")
  (timezone "Europe/Vienna")
  (keyboard-layout (keyboard-layout "us" "dvp"))
  (host-name "leviathan")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "martin")
                  (comment "Martin")
                  (group "users")
                  (home-directory "/home/martin")
                  (shell (file-append zsh "/bin/zsh"))
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (map specification->package 
                         (append SYSTEM-PACKAGES
                                 HYPRLAND-PACKAGES))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service gnome-desktop-service-type)
                 (service nvidia-service-type)

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout)
                                      (modules (cons nvda %default-xorg-modules))
                                      (drivers '("nvidia"))))

                 (simple-service 'dummy-profile etc-service-type `(("profile.d/00-dummy.sh" ,(plain-file "dummy.sh" "")))))

           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %desktop-services
             (gdm-service-type config =>
                               (gdm-configuration
                                 (inherit config)
                                 (wayland? #t)))
             (guix-service-type config =>
                                (guix-configuration
                                  (inherit config)
                                  (channels CHANNELS)
                                  (guix (guix-for-channels CHANNELS))
                                  (substitute-urls
                                    (append (list "https://substitutes.nonguix.org")
                                            %default-substitute-urls))
                                  (authorized-keys
                                    (append (list (local-file "./nonguix-signing-key.pub"))
                                            %default-authorized-guix-keys)))))))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "c2edda56-af92-4586-a959-6bebff74cc4d"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "46AF-D043"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/mnt/hdd")
                         (device (uuid "40c70d62-2862-41d4-8dd3-fc9c1984224a" 'ext4))
                         (type "ext4"))
                       %base-file-systems)))
