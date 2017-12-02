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


(org-babel-load-file (expand-file-name "~/.emacs.d/config/config.org"))



;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-in-non-selected-windows (quote box))
 '(cursor-type (quote (bar . 3)))
 '(markdown-command "multimarkdown")
 '(package-selected-packages (quote (markdown-mode try company))))

;; == 编辑器 ==

;; 主题
;;(load-theme 'monokai 1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)




;; 开启全局 Company 补全
(global-company-mode 1)

;; == 代码 ==

;; 加载 node 解释器
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 自动设置 js 文件的 mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; Markdown Mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
