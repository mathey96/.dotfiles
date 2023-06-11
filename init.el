;;; init.el --- Spacemacs Initialization File -*- no-byte-compile: t -*-
;;
;; Copyright (c) 2012-2022 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Avoid garbage collection during startup.
;; see `SPC h . dotspacemacs-gc-cons' for more info
(defconst emacs-start-time (current-time))
(setq gc-cons-threshold 402653184 gc-cons-percentage 0.6)
(load (concat (file-name-directory load-file-name) "core/core-load-paths")
      nil (not init-file-debug))
(load (concat spacemacs-core-directory "core-versions")
      nil (not init-file-debug))
(load (concat spacemacs-core-directory "core-dumper")
      nil (not init-file-debug))

;; Remove compiled core files if they become stale or Emacs version has changed.
(load (concat spacemacs-core-directory "core-compilation")
      nil (not init-file-debug))
(load spacemacs--last-emacs-version-file t (not init-file-debug))
(when (or (not (string= spacemacs--last-emacs-version emacs-version))
          (> 0 (spacemacs//dir-byte-compile-state
                (concat spacemacs-core-directory "libs/"))))
  (spacemacs//remove-byte-compiled-files-in-dir spacemacs-core-directory))
;; Update saved Emacs version.
(unless (string= spacemacs--last-emacs-version emacs-version)
  (spacemacs//update-last-emacs-version))

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (error (concat "Your version of Emacs (%s) is too old. "
                   "Spacemacs requires Emacs version %s or above.")
           emacs-version spacemacs-emacs-min-version)
  ;; Disabling file-name-handlers for a speed boost during init might seem like
  ;; a good idea but it causes issues like
  ;; https://github.com/syl20bnr/spacemacs/issues/11585 "Symbol's value as
  ;; variable is void: \213" when emacs is not built having:
  ;; `--without-compress-install`
  (let ((please-do-not-disable-file-name-handler-alist nil))
    (require 'core-spacemacs)
    (spacemacs/dump-restore-load-path)
    (configuration-layer/load-lock-file)
    (spacemacs/init)
    (configuration-layer/stable-elpa-init)
    (configuration-layer/load)
    (spacemacs-buffer/display-startup-note)
    (spacemacs/setup-startup-hook)
    (spacemacs/dump-eval-delayed-functions)
    (when (and dotspacemacs-enable-server (not (spacemacs-is-dumping-p)))
      (require 'server)
      (when dotspacemacs-server-socket-dir
        (setq server-socket-dir dotspacemacs-server-socket-dir))
      (unless (server-running-p)
        (message "Starting a server...")
        (server-start)))))
 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
; obrisati ako ne radi
(set-frame-parameter nil 'alpha-background 800) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 800)) ; For all new frames henceforth
;obrisati ako ne radi
(add-to-list 'default-frame-alist '(alpha . (100 . 100 )))
(setq global-display-line-numbers-mode 1)

(setq-default spacemacs-show-trailing-whitespace nil) ;; MOJ CONFIG
;; RELATIVNE LINIJE:
(add-hook 'prog-mode-hook 'display-line-numbers-mode) ;; MOJ CONFIG
(add-hook 'fundamental-mode-hook 'display-line-numbers-mode) ;; MOJ CONFIG
(add-hook 'org-mode-hook 'display-line-numbers-mode) ;; MOJ CONFIG
(add-hook 'hack-local-variables-hook (lambda () (setq truncate-lines t))) ;; nowrap u vimu
(load-theme 'gruvbox-dark-soft t)
(set-face-attribute 'lazy-highlight nil :foreground "black" :background "green")
(set-face-attribute 'region nil :background "#666")
(set-face-attribute 'region nil :background "#664" :foreground "#ffffff")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;;(global-set-key (kdb "<M-+>") 'zoom-frm-in)
;(global-set-key [M-+] 'help-for-help)

;;(spacemacs/declare-prefix "o" "custom")
;;(spacemacs/set-leader-keys "C-+" 'frm-zoom-out)
;;(defun frm-zoom()
;;  (interactive)
;;  'frm-zoom-in
  ; Insert your compound commands below

;;(use-package emacs
;;  :bind ("C-c e" . frm-zoom-in)
;;  :bind ("C-c d" . lsp-ui-doc-show)
;;
;;(spacemacs/declare-prefix "o" "own-menu")
;;(spacemacs/set-leader-keys  "os" 'frm-zoom)

;;(global-set-key (kbd "M-n") (lambda () (interactive) (forward-line 5)))


;;(defun frm-zoom-plus (&optional arg)
;;  (interactive "P")
;;  (frm-zoom-in arg "u"))

;;(global-set-key (kbd "C-+")
;;  (lambda () (interactive) (frm-zoom-in)))
;; (require 'load-directory)
;;(load-directory "home/matija/.emacs.d/layers/+spacemacs/spacemacs-visual/local/zoom-frm/zoom-frm.el")

(global-set-key (kbd "C-+") 'zoom-frm-in)
(global-set-key (kbd "C--") 'zoom-frm-out)
(global-set-key (kbd "C-*") 'lsp-ui-doc-show)
(setq display-line-numbers-type 'relative)
;;(spacemacs/declare-prefix "o" "own-menu")
;;(spacemacs/set-leader-keys  "ot" 'hidden-mode-line-mode ')
(set-fringe-mode 0)

;;(define-key org-mode-map (kbd "<f8>") 'org-agenda-show-unscheduled)


;;(add-to-list 'load-path "~/.emacs.d/lisp/")
;;(require 'codegpt)
;;    (defun hello ()
;;      "Hello World and you can call it via M-x hello."
;;      (interactive)
;;      (message "Hello World!"))
;;     (global-set-key (kbd "C-c g") 'hello)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("c" "Code Questions" entry (file+headline "~/org/code-questions.org" "questions")
         "* TODO %?\n  %i\n  %a")
        ("s" "Code notes" entry (file+headline "~/org/code-notes.org" "notes")
        "* TODO %?\n  %i\n  %a")
        ("o" "Open-Source code notes" entry (file+headline "~/org/open-source-research.org" "notes")
         "* TODO %?\n  %i\n  %a")
        ("d" "Diplomski-beleške" entry (file+headline "~/org/diplomski.org" "Diplomski-beleške-za-profesora")
         "* TODO %?\n  %i\n  %a")))
;(defun my-split-window-func ()
;  (interactive)
;  (split-window-below)
;  (set-window-buffer (next-window) (other-buffer)))
;
;(global-set-key (kbd "C-c 2") #'my-split-window-func)

(defun popup-term ()
    (interactive)
    (split-window-right-and-focus)
    (term "/bin/zsh"))

(defun popup-term-below ()
  (interactive)
  (split-window-below-and-focus)
  (term "/bin/zsh"))

(defun popup-vterm ()
  (interactive)
  (split-window-right-and-focus)
  (vterm ))

(global-set-key (kbd "C-c t") #'popup-term)
(global-set-key (kbd "C-c v") #'popup-vterm)
(global-set-key (kbd "C-i") #'evil-jump-forward)
(global-set-key (kbd "C-o") #'evil-jump-backward)

;;(global-set-key (kbd "C-c f") #'fuzzy-finder)
(global-set-key (kbd "C-c m") #'hidden-mode-line-mode)
(define-key evil-normal-state-map (kbd "C-,") 'evil-repeat-find-char-reverse)

(global-set-key (kbd "C-c y") #'popup-term-below)
(setq inhibit-startup-message t)
;;evil-repeat-find-char
;; da ne izbacuje active process check
(require 'cl-lib)

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (cl-letf (((symbol-function #'process-list) (lambda ())))
    ad-do-it))
(setq kill-buffer-query-functions nil)
(setq smartparens-mode -1)



(defun maximize_other_win()
  (interactive)
  (other-window 1)
  (toggle-maximize-buffer))

(global-set-key (kbd "C-c o") #'maximize_other_win)


;;(defun go-to-vimwiki () --- stavljeno u funcs.el
;;  (interactive)
;;  (find-file "/home/matija/.local/share/nvim/vimwiki"))
;;spacemacs/find-user-init-file

;;(global-set-key (kdb "SPC f e i") #'go-to-vimwiki)


(defun open-st-session ()
  (interactive)
  (evil-ex "!st &")
    (quit-window)
    (RET))


(global-set-key (kbd "C-c s") #'open-st-session)

;;(require 'funcs.el)
;;(defun find-def-from-decl ()
;;  (interactive)
;;  (beggining-of-line)
;;  (evil-visual-char)
;;  (evil-find-char "(" )
;;)

;;(global-set-key (kbd "C-c r") #'find-def-from-decl)

(global-set-key (kbd "C-c i") #'evil-numbers/inc-at-pt-incremental)
(global-set-key (kbd "C-c r") #'transpose-frame)

(defun getpwd ()
  (evil-goto-first-line)
  (evil-ex-search-forward)
  (evil-ex "home"))


(global-set-key (kbd "C-c g") #'getpwd)

(defun copy-file-name ()
  (interactive)
  (setq x buffer-file-name)
  (kill-new x))
(global-set-key (kbd "C-c f") #'copy-file-name)

(defun mark-buffer-globally ()
  "Mark the current buffer as modified in all frames."
  (interactive)
  (when (buffer-modified-p)
    (dolist (frame (frame-list))
      (with-selected-frame frame
        (when (not (eq (selected-window) (minibuffer-window)))
          (set-buffer-modified-p t))))))

(global-set-key (kbd "C-c u") 'mark-buffer-globally)
(setf dired-kill-when-opening-new-dired-buffer t)
(yas-global-mode 1)

(setq dmenu-cfg " | dmenu -l 9 | tr --delete \"\\n\"")

(defun dmenu-save-buffer-to-bookmark ()
    (interactive)
    (setq command (concat "echo "   "" buffer-file-name ""   "  >> "   "/home/matija/emacsbookmarks"))
    (setq file_already_bookmarked (shell-command-to-string (concat "grep -m 1 \""  buffer-file-name "\"" " /home/matija/emacsbookmarks | tr --delete \"\\n\"")))
    (if (not (string= buffer-file-name file_already_bookmarked))
        (shell-command command)
    ((print 'nil)))
(shell-command "sed -i \'/^$/d\' /home/matija/emacsbookmarks"))


(defun dmenu-select-buffer ()
    (interactive)
(if (string= buffer-file-name "\\n")
    (nil)
  (find-file (shell-command-to-string
             (concat "cat /home/matija/emacsbookmarks" dmenu-cfg)))))

(defun dmenu-clear-bookmark-list ()
    (interactive)
    (shell-command "echo \"\" > /home/matija/emacsbookmarks"))

(global-set-key (kbd "C-c b") 'dmenu-select-buffer)
(global-set-key (kbd "C-c [") 'dmenu-save-buffer-to-bookmark)
(global-set-key (kbd "C-c d") 'dmenu-clear-bookmark-list)


  ;;(buffer-file-name)

(defun fzfhello ()
(shell-command "fzf -e"))

(global-set-key (kbd "C-c q") #'fzfhello)
