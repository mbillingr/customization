(define-module (my-packages jj)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (guix licenses))

(define-public jujutsu
  (package
   (name "jujutsu")
   (version "0.31.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append "https://github.com/jj-vcs/jj/releases/download/v" version "/jj-v" version "-x86_64-unknown-linux-musl.tar.gz"))
	    (sha256 (base32 "0487k053kl9ifz4bx19af3as6zr612r1ifr0skl9cw31x30xh5xj"))))
   (build-system copy-build-system)
   (arguments '(#:install-plan '(("jj" "/bin/jj"))))
   (synopsis "A Git-compatible VCS that is both simple and powerful")
   (description "Jujutsu is a powerful version control system for software projects. It is designed from the ground up to be easy to use. This package uses released binaries.")
   (home-page "https://github.com/jj-vcs/jj")
   (license asl2.0)))
