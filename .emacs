(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq visible-bell t)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq default-frame-alist '((font . "Iosevka 13")))
(load-theme 'doom-rouge t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package dashboard
  :config
  (setq dashboard-projects-backend 'projectile)
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
			  (projects . 5)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-display-icons-p t)
  )

;; EXWM
(require 'exwm)
;; Set the initial workspace number.
(setq exwm-workspace-number 4)
;; Make class name the buffer name.
(add-hook 'exwm-update-class-hook
  (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;; Global keybindings.
(setq exwm-input-global-keys
      `(
	([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
        ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.	
        ([?\s-p] . (lambda (cmd) ;; s-&: Launch application.
			  (interactive (list (read-shell-command "$ ")))
			  (start-process-shell-command cmd nil cmd))
	 )
        ;; s-N: Switch to certain workspace.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch ,i))))
                  (number-sequence 0 9))
	,@(cl-mapcar (lambda (c n)
                           `(,(kbd (format "s-%c" c)) .
                             (lambda ()
                               (interactive)
                               (exwm-workspace-move-window ,n)
                               (exwm-workspace-switch ,n))))
                         '(?\) ?! ?@ ?# ?$ ?% ?^ ?& ?* ?\()
			 (number-sequence 0 9))
	;;
	([S-XF86MonBrightnessUp] . desktop-environment-brightness-increment-slowly)
	([S-XF86MonBrightnessDown] . desktop-environment-brightness-decrement-slowly)  
	([XF86MonBrightnessUp] . desktop-environment-brightness-increment)
	([XF86MonBrightnessDown] . desktop-environment-brightness-decrement)
	([XF86AudioLowerVolume] . desktop-environment-volume-decrement)
	([XF86AudioRaiseVolume] . desktop-environment-volume-increment)
	;;
	)
      )
;; Enable EXWM
(exwm-enable)
