(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq visible-bell t)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq default-frame-alist '((font . "Iosevka 13")))
(load-theme 'ef-dream t)
(setq backup-directory-alist `(("." . "~/.saves")))

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
;; (setq last-workspace 0)
;; (setq current-workspace last-workspace)
;; (require 'exwm)
;; ;; Set the initial workspace number.
;; (setq exwm-workspace-number 4)
;; ;; Make class name the buffer name.
;; (add-hook 'exwm-update-class-hook
;;   (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;; ;; Global keybindings.
;; (setq exwm-input-global-keys
;;       `(
;; 	([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
;;         ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.	
;;         ([?\s-p] . (lambda (cmd) ;; s-&: Launch application.
;; 			  (interactive (list (read-shell-command "$ ")))
;; 			  (start-process-shell-command cmd nil cmd))
;; 	 )
;;         ;; s-N: Switch to certain workspace.
;;         ,@(mapcar (lambda (i)
;;                     `(,(kbd (format "s-%d" i)) .
;;                       (lambda ()
;; 			(setq last-worspace current-workspace)
;; 			;; (setq current-worskpace i)
;;                         (interactive)
;; 			(exwm-workspace-switch ,i))))
;;                   (number-sequence 0 9))
;; 	,@(cl-mapcar (lambda (c n)
;;                            `(,(kbd (format "s-%c" c)) .
;;                              (lambda ()
;;                                (interactive)
;;                                (exwm-workspace-move-window ,n)
;;                                (exwm-workspace-switch ,n))))
;;                          '(?\) ?! ?@ ?# ?$ ?% ?^ ?& ?* ?\()
;; 			 (number-sequence 0 9))
;; 	;;
;; 	([S-XF86MonBrightnessUp] . desktop-environment-brightness-increment-slowly)
;; 	([S-XF86MonBrightnessDown] . desktop-environment-brightness-decrement-slowly)  
;; 	([XF86MonBrightnessUp] . desktop-environment-brightness-increment)
;; 	([XF86MonBrightnessDown] . desktop-environment-brightness-decrement)
;; 	([XF86AudioLowerVolume] . desktop-environment-volume-decrement)
;; 	([XF86AudioRaiseVolume] . desktop-environment-volume-increment)
;; 	;;
;; 	([s-tab] . (lambda ()
;; 		     (interactive)
;; 		     (exwm-workspace-switch, last-workspace)))
;; 	([?\s-v] . (lambda ()
;; 		     (interactive)
;; 		     (dired, "~")))
;; 	;;([s-return] . (lambda ()
;; 	;;		(split-window-horizontally)
;; 	;;		(interactive)
;; 	;;		(term, "/bin/zsh"))
;; 	;; )
;; 	([s-return] . (lambda ()
;; 		     (interactive)
;; 		     (start-process-shell-command "urxvt" nil "urxvt")))
;; 	)
;;       )
;; ;; Enable EXWM
;; (exwm-enable)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("90185f1d8362727f2aeac7a3d67d3aec789f55c10bb47dada4eefb2e14aa5d01" "59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b" "aff0396925324838889f011fd3f5a0b91652b88f5fd0611f7b10021cc76f9e09" "e85a354f77ae6c2e47667370a8beddf02e8772a02e1f7edb7089e793f4762a45" "00d7122017db83578ef6fba39c131efdcb59910f0fac0defbe726da8072a0729" "ea4dd126d72d30805c083421a50544e235176d9698c8c541b824b60912275ba1" "fae5872ff90462502b3bedfe689c02d2fa281bc63d33cb007b94a199af6ccf24" "b41d0a9413fb0034cea34eb8c9f89f6e243bdd76bccecf8292eb1fefa42eaf0a" "b33955472cb61a721c59c705afda11fea906756d38b3c2eba61698f4e3f82897" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(package-selected-packages
   '(ef-themes tron-legacy-theme projectile markdown-mode haskell-mode gruber-darker-theme exwm desktop-environment dashboard)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
