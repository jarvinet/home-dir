
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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ede-project-directories (quote ("/Users/tapani.jarvinen/Documents/workspace/slots-web")))
 '(same-window-buffer-names (quote ("*shell*" "*mail*" "*info*" "*inferior-lisp*" "*ielm*" "*scheme*" "*Buffer List*"))))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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



(put 'narrow-to-region 'disabled nil)

;;; My location for external packages.
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(load "~/.emacs.d/nxhtml/autostart.el")

;; set cc-mode indentation amount
(setq-default c-basic-offset 2)

;; disable exiting emacs with Ctrl-x Ctrl-c
(global-set-key [(ctrl x)(ctrl c)] nil)


(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(set-cursor-color "Red")

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'mongo)

