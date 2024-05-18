(setq inhibit-startup-message t)
(tooltip-mode -1)
;; Visible bell
(setq visible-bell t)
(tool-bar-mode -1)
(menu-bar-mode -1)
;;(scroll-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("774218d0781ca9aad07888de412eac35b7920bafc10ecc014ecf493d7a74b310" "77f1e155387d355fbbb3b382a28da41cc709b2a1cc71e7ede03ee5c1859468d2" "2ccdb4796d3238dd0794f7869750fb0e81fe4f9212f9528cfd4f41da0c78cf25" "821c37a78c8ddf7d0e70f0a7ca44d96255da54e613aa82ff861fe5942d3f1efc" "afeb7b07dbc1a4cfadb24f3ef6c8cf5e63051bf76411779f03a0fe3aadc07768" "58c996beb973f7e988ee4fd21c367b7a5bbdb0622ddfbbd112672a7b4e3d3b81" "a68624bd5c4bec879ee59cd3039531b6229766a8b8ed0e79eef2642f14dbda32" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" default))
 '(elfeed-feeds
   '("https://www.reddit.com/r/virgin.rss"))
 '(package-selected-packages
   '(elfeed dmenu timu-caribbean-theme kuronami-theme php-mode tron-legacy-theme exwm haskell-mode evil emms emmet-mode moe-theme dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :height 120)
(load-theme 'timu-caribbean)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'emms-setup)
(emms-all)

(setq emms-player-list '(emms-player-mpv))

(setq emms-source-file-default-directory "/home/jose/Music")

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
;;(require 'evil)
;;(evil-mode 1)
