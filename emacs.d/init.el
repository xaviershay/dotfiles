;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/")

; Carbon EMACS
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'mac-key-mode) (mac-key-mode 1))
(setq mac-option-modifier 'meta) 

(set-default-font
  "-apple-inconsolata_dz-medium-r-normal--12-120-72-72-m-120-iso10646-1")

;; don't show startup messages
(setq inhibit-startup-message t)          
(setq inhibit-startup-echo-area-message t)

; General editing
(setq tab-width 2)

; isearch puts cursor at front of search, not in the middle
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
 (defun my-goto-match-beginning ()
    (when isearch-forward (goto-char isearch-other-end)))

;; Some Mac-friendly key counterparts
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)

(require 'color-theme)
    (color-theme-initialize)
    (color-theme-taylor)

(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
    (if (frame-parameter f 'fullscreen) nil 'fullboth)))
(add-hook 'after-make-frame-functions 'fullscreen)

;; VIM compatibility - need those movement keys!
(setq viper-mode t)
(require 'viper)
(require 'vimpulse)

; This function is broken for me with git, don't need atm
(defun viper-maybe-checkout (buf) ())

; Ruby
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
;; TODO: DRY this up
(setq auto-mode-alist  (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rake$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("^Rakefile$" . ruby-mode) auto-mode-alist))

(setq ruby-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq ruby-indent-level 2))))

(setq javascript-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq javascript-indent-level 2))))

(eval-after-load 'ruby-mode
  '(progn
     (ignore-errors (require 'ruby-compilation))
     (setq ruby-use-encoding-map nil)
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)

     ;; Ruby mode overrides this with something lame, so define it back
     (define-key ruby-mode-map (kbd "C-M-h") 'backward-kill-word)))

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; ruby-test
;; C-x C-SPC => run this test/spec
;; C-x t     => run tests/specs in this file
;; C-c t     => toggle between specification and implementation
;; (require 'ruby-test)

