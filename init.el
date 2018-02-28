;; Setup Package.el
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

;; Setup use-package.er
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Window config
(use-package switch-window
  :config
  (setq switch-window-shortcut-style 'qwerty)
  :bind ("C-x o" . switch-window))

;; Ido setup
(use-package ido
  :init
  (ido-mode t))

;; Rainbow delimiters setup
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; company-mode setup
(use-package company
  :custom
  (company-idle-delay 0.5)
  :config
  (defun mewa/push-company-backend (backend)
    "Add company BACKEND as a buffer-local"
    (make-local-variable 'company-backends)
    (push backend company-backends))
  (global-company-mode t))

(use-package company-flx
  :after
  (company)
  :config
  (company-flx-mode t))

;; Haskell setup
(use-package haskell-mode
  :config
  (interactive-haskell-mode t))

(use-package intero
  :after (haskell company)
  :hook (haskell-mode . intero-mode))

;; Lisp setup
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package slime-company
  :after (slime))

;; Elm setup
(use-package elm-mode
  :hook
  (elm-mode . (lambda () (mewa/push-company-backend 'company-elm))))

;; Go setup
(use-package go-mode)

(use-package company-go
  :after (go-mode company)
  :hook
  (go-mode . (lambda () (mewa/push-company-backend 'company-go))))

;; Set Monokai theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

;; YAML setup
(use-package yaml-mode)

;; Rust setup
(use-package rust-mode)

;; Front-end
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

;; Indent with spaces
(setq-default indent-tabs-mode nil)

;; Setup line numbering
(setq linum-format "%d ")
(global-linum-mode 1)

;; Disable menu bar
(menu-bar-mode 0)

;; Life's too short
(fset 'yes-or-no-p 'y-or-n-p)

;; Setup parenthesis
(show-paren-mode 1)
(electric-pair-mode 1)

;; Enable subword-mode globally
(global-subword-mode t)

;; Switch between header/implementation
(global-set-key (kbd "C-c f") 'ff-find-other-file)

(provide 'init)
;;; init.el ends here
