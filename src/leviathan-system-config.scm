;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (gnu packages shells)
             (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
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
  (packages (append (map specification->package '("screen"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service gnome-desktop-service-type)

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout)))

                 (simple-service 'dummy-profile etc-service-type `(("profile.d/00-dummy.sh" ,(plain-file "dummy.sh" "")))))

           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %desktop-services
             (guix-service-type config =>
                                (guix-configuration
                                  (inherit config))))))
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
                         (type "vfat")) %base-file-systems)))
