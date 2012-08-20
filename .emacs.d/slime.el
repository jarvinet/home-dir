;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SLIME Begin


(global-font-lock-mode 1)  ;enable syntax highlighting

;; possibly OS-specific values:
(setenv "SBCL_HOME" "/usr/lib/sbcl") ;for non-standard location
(setq inferior-lisp-program "/usr/bin/sbcl"
      ;slime-path (expand-file-name "~/.sbcl/site/slime-2.0/") ;ASDF-install
      slime-path (expand-file-name "~/lisp/slime/") ;CVS version
      ;w3m-command "/sw/bin/w3m"   ; Fink version
      ;w3m-command "/opt/local/bin/w3m"  ; MacPorts version
      w3m-command "/usr/bin/w3m" ; Ubuntu or Debian version
      cltl2-url "file:///usr/local/share/doc/cltl/clm/node1.html"
      hyperspec-prog (concat slime-path "hyperspec")
      hyperspec-path "/usr/local/share/doc/HyperSpec/")

;; settings for Common Lisp development:
(setq lisp-indent-function 'common-lisp-indent-function
      ;slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-startup-animation nil
      common-lisp-hyperspec-root (concat "file://" hyperspec-path)
      common-lisp-hyperspec-symbol-table (concat hyperspec-path "Data/Map_Sym.txt")
      w3m-default-homepage common-lisp-hyperspec-root
      ;browse-url-browser-function 'w3m
      w3m-symbol 'w3m-default-symbol
      w3m-key-binding 'info
      w3m-coding-system 'utf-8
      w3m-default-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)

(add-to-list 'load-path (concat slime-path "slime"))
(add-to-list 'load-path (concat slime-path "slime/contrib"))
(require 'slime)
;; next two lines only apply to Autumn 2007/post-2.0 versions of SLIME from CVS:
(require 'slime-editing-commands)
(add-hook 'slime-mode-hook 'slime-bind-editing-commands)
(slime-setup)

;;;; SLIME End
