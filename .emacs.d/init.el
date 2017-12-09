;; 设置国内源
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(
                            ("gnu" . "http://elpa.emacs-china.org/gnu/")
                            ("melpa" . "http://elpa.emacs-china.org/melpa/")
			    )
    )
  (package-initialize)
)

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
        company
        swiper
        counsel
        hungry-delete
        smartparens
        js2-mode
        nodejs-repl
        exec-path-from-shell
        ;;monokai-theme
        markdown-mode
) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))

(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))


;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 自动设置 js 文件的 mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;(org-babel-load-file (expand-file-name "~/.emacs.d/config/config.org"))


(org-babel-load-file (expand-file-name "~/.emacs.d/lisp/init-defaults.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/lisp/init-ui.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/lisp/init-packages.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/lisp/init-keybindings.org"))
