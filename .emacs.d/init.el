
;; this toggles between horizontal and vertical window split
;; this has two shortcomings:
;; 1) it only works if there is exactly two windows
;; 2) if both windows are displaying the same buffer, toggling does not
;;    preserve current point location in the other window
(defun toggle-window-split ()
  "toggle between vertical and horizontal plit of two windows"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(defun toggle-window-split ()
  "toggle between vertical and horizontal plit of two windows"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
        (point-to-register 'a)
        (other-window 1)
        (point-to-register 'b)
        (other-window 1)
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))
          (register-to-point 'a)
          (other-window 1)
          (register-to-point 'b)
          (other-window 1)
))))

;; this maps window split to ctr-x-4-t
(define-key ctl-x-4-map "t" 'toggle-window-split)

;; save and recall window configurations
;; Ctrl-x left/right arrow
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; use shift-arrowkeys to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; (global-set-key (kbd "C-x C-b" buffer-menu)

;; this shows the buffer *Buffer List* in the same window
;; instead of creating a new window
 (custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
  '(same-window-buffer-names (quote ("*shell*" "*mail*" "*info*" "*inferior-lisp*" "*ielm*" "*scheme*" "*Buffer List*"))))
 (custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
  )

;; do not use tabs for indenting
;; indent-tabs-mode is a per buffer variable, this sets its default value
(setq-default indent-tabs-mode nil)

;; set indent level 4
(setq-default c-default-style "k&r")
(setq-default c-basic-offset 4)
(setq-default c++-basic-offset 4)

;; get rid of the toolbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; bind Alt-x to execute-extended-command
(global-set-key [(alt x)] 'execute-extended-command)

;; bind goto-line to meta-g
(global-set-key [(meta g)] 'goto-line)

;; tramp enables you to edit files on remote systems
;; also useful in editing files as another user
;; load tramp and set the default connection method to ssh
; tramp seems to interfere with gud, hence not loading on startup
; (require 'tramp)
; (setq tramp-default-method "ssh")

;; turn syntax highlighting on
(global-font-lock-mode 1)

;; display matching parenthesis
(require 'paren)
(show-paren-mode 1)

;; define ctrl up-arrow (down-arrow) to move up (down) n lines
(global-set-key [(ctrl up)] (function (lambda () (interactive) (previous-line 10))))
(global-set-key [(ctrl down)] (function (lambda () (interactive) (next-line 10))))
(global-set-key [(ctrl p)] (function (lambda () (interactive) (previous-line 10))))
(global-set-key [(ctrl n)] (function (lambda () (interactive) (next-line 10))))

(global-set-key [(ctrl f)] 'forward-word)
(global-set-key [(ctrl b)] 'backward-word)

;(global-set-key (kbd "C-<down>") (function (lambda () (interactive) (next-line 10))))

;; scroll buffer up/down one line at a time without moving the point
;; using alt-up and alt-down
(global-set-key [(meta down)]  (function (lambda () (interactive) (scroll-up 1))))
(global-set-key [(meta up)] (function (lambda () (interactive) (scroll-down 1))))
(global-set-key [(meta n)]  (function (lambda () (interactive) (scroll-up 1))))
(global-set-key [(meta p)] (function (lambda () (interactive) (scroll-down 1))))

;; scroll buffer up/down ten lines at a time without moving the point
;; using ctrl-alt-up and ctrl-alt-down
;(global-set-key [(ctrl alt up)] (function (lambda () (interactive) (scroll-down 10))))
;(global-set-key [(ctrl alt down)] (function (lambda () (interactive) (scroll-up 10))))
(global-set-key [(ctrl meta p)] (function (lambda () (interactive) (scroll-down 10))))
(global-set-key [(ctrl meta n)] (function (lambda () (interactive) (scroll-up 10))))

; matlab mode
;;(autoload 'matlab-mode "/home01/tapanij/build/emacs/matlab/matlab.el" "Enter Matlab mode." t)

;; csv mode
;;(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
;;(autoload 'csv-mode "~/.emacs.d/csv-mode.el" "Major mode for editing comma-separated value files." t)

;; enable cperl mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;; shrink and enlarge windows
;(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;(global-set-key (kbd "S-C-<down>") 'shrink-window)
;(global-set-key (kbd "S-C-<up>") 'enlarge-window)


;;; - experimental stuff - does not seem to work very well

; Outline-minor-mode key map
;  (define-prefix-command 'cm-map nil "Outline-")
;  ; HIDE
;  (define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
;  (define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
;  (define-key cm-map "o" 'hide-other)        ; Hide other branches
;  (define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
;  (define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
;  (define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
;  ; SHOW
;  (define-key cm-map "a" 'show-all)          ; Show (expand) everything
;  (define-key cm-map "e" 'show-entry)        ; Show this heading's body
;  (define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
;  (define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
;  (define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
;  ; MOVE
;  (define-key cm-map "u" 'outline-up-heading)                ; Up
;  (define-key cm-map "n" 'outline-next-visible-heading)      ; Next
;  (define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
;  (define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
;  (define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
;  (global-set-key "\M-o" cm-map)


;  ;; Load CEDET - begin
;  (add-to-list 'load-path "~/build/emacs/cedet-1.0pre4/common")
;  
;  (load-file "cedet.el")
;  
;  ;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;  ;; Select one of the following:
;  
;  ;; * This enables the database and idle reparse engines
;  ;;(semantic-load-enable-minimum-features)
;  
;  ;; * This enables some tools useful for coding, such as summary mode
;  ;;   imenu support, and the semantic navigator
;  (semantic-load-enable-code-helpers)
;  
;  ;; * This enables even more coding tools such as the nascent intellisense mode
;  ;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;  ;; (semantic-load-enable-guady-code-helpers)
;  
;  ;; * This turns on which-func support (Plus all other code helpers)
;  ;; (semantic-load-enable-excessive-code-helpers)
;  
;  ;; This turns on modes that aid in grammar writing and semantic tool
;  ;; development.  It does not enable any other features such as code
;  ;; helpers above.
;  ;; (semantic-load-enable-semantic-debugging-helpers)
;  
;  ;; Load CEDET - end
;  
;  ;; Load ECB (Emacs Code Browser) - begin
;  (add-to-list 'load-path "~/build/emacs/ecb-2.32")
;  
;  (require 'ecb-autoloads)
;  ;; Load ECB (Emacs Code Browser) - end


;; sort buffers in buffer list
;; (defun sort-buffers-buffer-name ()
;;   "Put the buffer list in alphabetical order."
;;   (interactive)
;;   (dolist (buff (buffer-list-sorted-buffername)) (bury-buffer buff))
;;   (when (interactive-p) (list-buffers)))

;; (defun buffer-list-sorted-buffername ()
;;   (sort (buffer-list) 
;;   	(function
;;   	 (lambda (buf1 buf2) 
;;            (string<
;;             (downcase (buffer-name buf1))
;;             (downcase (buffer-name buf2)))))))

;; (defun sort-buffers-file-name ()
;;   "Put the buffer list in alphabetical order."
;;   (interactive)
;;   (dolist (buff (buffer-list-sorted-filename)) (bury-buffer buff))
;;   (when (interactive-p) (list-buffers)))

;; (defun buffer-list-sorted-filename2 ()
;;   (sort (buffer-list) 
;;   	(function
;;   	 (lambda (buf1 buf2) 
;;            (string<
;;             (downcase (buffer-file-name buf1))
;;             (downcase (buffer-file-name buf2)))))))

;; (defun buffer-list-sorted-filename ()
;;   (sort (buffer-list) 
;;   	(function
;;   	 (lambda (buf1 buf2) 
;;            (let ((bf1 (buffer-file-name buf1))
;;                  (bf2 (buffer-file-name buf2)))
;;              `(string< bf1 bf2))))))
           

;;(global-set-key "\M-b"    'sort-buffers-buffer-name)
;;(global-set-key "\M-b"    'sort-buffers-file-name)



;; function that toggles between these two:
;; save current window configuration, display current buffer in one window
;; restore saved window configuration 
;; (setq window-configuration-stack nil)

;; (defun stack-push (item stack)
;;   (setq stack (cons item stack)))

;; (defun stack-top (stack)
;;   (car stack))

;; (defun stack-pop (stack)
;;   (setq stack (cdr stack)))

;; (defun stack-string (stack)
;;   (if (eq stack nil)
;;       "nil"
;;     (string (car stack) (stack-string (cdr stack)))))

;; (defun push-window-configuration ()
;;   (interactive)
;;   (setq window-configuration-stack 
;;         (cons (current-window-configuration) 
;;               window-configuration-stack))
;;   (message "Window configuration saved"))

;; (defun pop-window-configuration ()
;;   (interactive)
;;   (let ((top (car window-configuration-stack))
;;         (rest (cdr window-configuration-stack)))
;;     (if (window-configuration-p top)
;;         (progn 
;;           (set-window-configuration top)
;;           (setq window-configuration-stack rest)
;;           (message "Window configuration restored"))
;;       (message "No saved window configuration"))))
      
;; (defun print-window-configuration-stack ()
;;   (interactive)
;;   (message (stack-string window-configuration-stack)))


;; ;; this maps toggle one window to ctr-x-4-o
;; ;(define-key ctl-x-4-map "o" 'toggle-one-window)
;; (define-key ctl-x-4-map "p" 'push-window-configuration)
;; (define-key ctl-x-4-map "o" 'pop-window-configuration)
;; (define-key ctl-x-4-map "r" 'print-window-configuration-stack)

(put 'narrow-to-region 'disabled nil)

;;; My location for external packages.
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;(require 'php-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(load "~/.emacs.d/nxhtml/autostart.el")

;; set cc-mode indentation amount
(setq-default c-basic-offset 2)

;; disable exiting emacs with Ctrl-x Ctrl-c
(global-set-key [(ctrl x)(ctrl c)] nil)

; (require 'undo-tree)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;(load "elscreen" "ElScreen" t)

;(require 'buff-menu+)
(add-to-list 'load-path "~/.emacs.d/bookmark+")
(require 'bookmark+)

(set-cursor-color "Red")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'mongo)
(require 'multi-term)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
