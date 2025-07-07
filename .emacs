(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq visible-bell t)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)
(defalias 'yes-or-no-p 'y-or-n-p)
(electric-indent-mode 0)
(setq default-frame-alist '((font . "FiraCode Nerd Font 13")))
;;(setq default-frame-alist '((font . "Iosevka 13")))
;;(load-theme 'doom-sourcerer t)
;;(load-theme 'doom-miramare t)
(load-theme 'ef-dream t)
;;(load-theme 'gruvbox t)

(require 'multiple-cursors)
(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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
  (setq dashboard-items '((recents  . 4)
			  (projects . 4)))
  (setq dashboard-startup-banner 'logo)
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
   '("211621592803ada9c81ec8f8ba0659df185f9dc06183fcd0e40fbf646c995f23"
     "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22"
     "51fa6edfd6c8a4defc2681e4c438caf24908854c12ea12a1fbfd4d055a9647a3"
     "8363207a952efb78e917230f5a4d3326b2916c63237c1f61d7e5fe07def8d378"
     "18a1d83b4e16993189749494d75e6adb0e15452c80c431aca4a867bcc8890ca9"
     "75b371fce3c9e6b1482ba10c883e2fb813f2cc1c88be0b8a1099773eb78a7176"
     "80f6ec0264b1b0a1449a6b74f7fb407e25118853bf6c96a9c21f4eef3143d926"
     "d5fd482fcb0fe42e849caba275a01d4925e422963d1cd165565b31d3f4189c87"
     "2b501400e19b1dd09d8b3708cefcb5227fda580754051a24e8abf3aff0601f87"
     "ff24d14f5f7d355f47d53fd016565ed128bf3af30eb7ce8cae307ee4fe7f3fd0"
     "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a"
     "9d5124bef86c2348d7d4774ca384ae7b6027ff7f6eb3c401378e298ce605f83a"
     "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33"
     "4b6cc3b60871e2f4f9a026a5c86df27905fb1b0e96277ff18a76a39ca53b82e1"
     "b754d3a03c34cfba9ad7991380d26984ebd0761925773530e24d8dd8b6894738"
     "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478"
     "2078837f21ac3b0cc84167306fa1058e3199bbd12b6d5b56e3777a4125ff6851"
     "0d2c5679b6d087686dcfd4d7e57ed8e8aedcccc7f1a478cd69704c02e4ee36fe"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392"
     "c5878086e65614424a84ad5c758b07e9edcf4c513e08a1c5b1533f313d1b17f1"
     "b1791a921c4f38cb966c6f78633364ad880ad9cf36eef01c60982c54ec9dd088"
     "ac893acecb0f1cf2b6ccea5c70ea97516c13c2b80c07f3292c21d6eb0cb45239"
     "b3ba955a30f22fe444831d7bc89f6466b23db8ce87530076d1f1c30505a4c23b"
     "11819dd7a24f40a766c0b632d11f60aaf520cf96bd6d8f35bae3399880937970"
     "6af300029805f10970ebec4cea3134f381cd02f04c96acba083c76e2da23f3ec"
     "b9c002dc827fb75b825da3311935c9f505d48d7ee48f470f0aa7ac5d2a595ab2"
     "19b62f442479efd3ca4c1cef81c2311579a98bbc0f3684b49cdf9321bd5dfdbf"
     "a3a71b922fb6cbf9283884ac8a9109935e04550bcc5d2a05414a58c52a8ffc47"
     "d6b369a3f09f34cdbaed93eeefcc6a0e05e135d187252e01b0031559b1671e97"
     "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac"
     "95b51aab1acd95ebcc7f47a60dd02d1a6b4b2c4aa68027b6d4138c2f70c583ae"
     "ae20535e46a88faea5d65775ca5510c7385cbf334dfa7dde93c0cd22ed663ba0"
     "71b688e7ef7c844512fa7c4de7e99e623de99a2a8b3ac3df4d02f2cd2c3215e7"
     "4c16a8be2f20a68f0b63979722676a176c4f77e2216cc8fe0ea200f597ceb22e"
     "3d9938bbef24ecee9f2632cb25339bf2312d062b398f0dfb99b918f8f11e11b1"
     "c038d994d271ebf2d50fa76db7ed0f288f17b9ad01b425efec09519fa873af53"
     "d609d9aaf89d935677b04d34e4449ba3f8bbfdcaaeeaab3d21ee035f43321ff1"
     "541282f66e5cc83918994002667d2268f0a563205117860e71b7cb823c1a11e9"
     "cee5c56dc8b95b345bfe1c88d82d48f89e0f23008b0c2154ef452b2ce348da37"
     "a0e9bc5696ce581f09f7f3e7228b949988d76da5a8376e1f2da39d1d026af386"
     "2551f2b4bc12993e9b8560144fb072b785d4cddbef2b6ec880c602839227b8c7"
     "90185f1d8362727f2aeac7a3d67d3aec789f55c10bb47dada4eefb2e14aa5d01"
     "59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "aff0396925324838889f011fd3f5a0b91652b88f5fd0611f7b10021cc76f9e09"
     "e85a354f77ae6c2e47667370a8beddf02e8772a02e1f7edb7089e793f4762a45"
     "00d7122017db83578ef6fba39c131efdcb59910f0fac0defbe726da8072a0729"
     "ea4dd126d72d30805c083421a50544e235176d9698c8c541b824b60912275ba1"
     "fae5872ff90462502b3bedfe689c02d2fa281bc63d33cb007b94a199af6ccf24"
     "b41d0a9413fb0034cea34eb8c9f89f6e243bdd76bccecf8292eb1fefa42eaf0a"
     "b33955472cb61a721c59c705afda11fea906756d38b3c2eba61698f4e3f82897"
     "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700"
     "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
     default))
 '(package-selected-packages
   '(afternoon-theme curry-on-theme dashboard desktop-environment
		     doom-themes dracula-theme ef-themes elm-mode evil
		     exwm gruber-darker-theme gruvbox-theme
		     haskell-mode lua-mode magit markdown-mode
		     multiple-cursors neotree ocaml-eglot php-mode
		     projectile rust-mode terraform-mode
		     tron-legacy-theme typespec-ts-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
