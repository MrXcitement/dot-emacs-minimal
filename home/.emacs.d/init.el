;;; emacs-minimal.el --- A minimal emacs configuration

;; Mike Barker <mike@thebarkers.com>
;; January 4th, 2022

;; This configuration was heavily influenced by:
;; https://github.com/susam/emfy


;;; Tweak UI
(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen t)
(column-number-mode)

;;; Customize Theme
(load-theme 'tango-dark)

;;; Minibuffer Completion
(ido-mode 1)
(ido-everywhere)
(setq ido-enable-flex-matching t)
(fido-mode)

;;; Show Stray Whitespace
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;;; Single Space for Sentence Spacing
(setq sentence-end-double-space nil)

;;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq js-indent-level 2)
(setq css-indent-offset 2)

;;; Highlight Parentheses
(setq show-paren-delay 0)
(show-paren-mode)

;;; Keep Working Directory Tidy
(make-directory "~/tmp/emacs/auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/tmp/emacs/auto-save/" t)))
(setq backup-directory-alist '(("." . "~/tmp/emacs/backup/")))
(setq backup-by-copying t)

;;; Start server.
(require 'server)
(unless (server-running-p)
  (server-start))

(require 'package)

; Add Melpa as the default Emacs Package repository
; only contains a very limited number of packages
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


; Activate all the packages (in particular autoloads)
(package-initialize)

; Update your local package index
(unless package-archive-contents
  (package-refresh-contents))

; List the packages you want
(setq package-list '(evil
                     evil-leader))

; Install all missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'evil)
(evil-mode t)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "b" 'switch-to-buffer
  "w" 'save-buffer)
