(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(company-auto-complete nil)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(elpy-rpc-python-command "/home/vishnu/.virtualenvs/tf/bin/python")
 '(nyan-mode t)
 '(package-selected-packages
   (quote
    (magit yaml-mode react-snippets web-mode-edit-element company-quickhelp tide treemacs ivy-rich counsel use-package nyan-mode sr-speedbar cmake-ide flycheck-irony company-irony-c-headers company-irony irony rtags elpy jedi json-mode cmake-mode ace-window flycheck bazel-mode company-jedi))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Default to python 3
;; (setq python-shell-interpreter "python3")
;; (setq python-shell-interpreter "/home/vishnu/.virtualenvs/comma/bin/python3")

;; User modifications

(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(elpy-enable)
(setq elpy-rpc-python-command "python")




;; C++, C
;; rtags
(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enable t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)


;; (require 'rtags-helm)
;; .(setq rtags-use-helm t)

;; irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-irony))
(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;; flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; cmake
(cmake-ide-setup)


;; Other
;; enable key
(global-set-key "\C-cd" 'kill-whole-line)


;; bind key to ace window
(global-set-key (kbd "C-x o") 'ace-window)


;; Desktop save
(desktop-save-mode)
(setq desktop-path '("~/.emacs.d/.cache/"))
(desktop-read)


;; Speedbar
(require 'sr-speedbar)

;; display line number mode
(global-display-line-numbers-mode)


;; Enable Ivy
(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
	 ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))


;; treemacs
(bind-key "C-c t" 'treemacs-select-window)


;; yas-snippets
(yas-global-mode 1)

;; org
(setq org-startup-truncated nil)
(setq org-log-done 'time)

;; term
;; fix scroll
(eval-after-load 'term
  '(progn
     (setq term-scroll-to-bottom-on-output t)))

;; load other files
(load "~/.emacs.d/init.el")
(load "~/.emacs.d/funs.el")
;; (load "~/.emacs.d/yaml-mode.el")


;; ;; Load yaml
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
