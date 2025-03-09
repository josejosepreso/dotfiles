module Keys where

myKeys :: [(String, X ())]
myKeys = [ ("<XF86AudioRaiseVolume>", spawn "amixer set PCM 5%+")
         , ("<XF86AudioLowerVolume>", spawn "amixer set PCM 5%-")
         , ("<XF86AudioMute>", spawn "amixer set PCM toggle")
         
         , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +3%")
         , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 3%-")
         
         , ("<XF86AudioNext>", spawn "mpc next")
         , ("<XF86AudioPrev>", spawn "mpc prev")
         , ("<XF86AudioPlay>", spawn "mpc toggle")
         
         --- Screenshot
         , ("<Print>", spawn "flameshot gui")
         
         --- Open Terminal
         , ("M-<Return>", spawn "urxvt")
         
         --- Kill window
         , ("M-w", kill)
         
         , ("M-c", spawn "st -e ncmpcpp")
         , ("M-v", spawn "urxvt -e ranger")
         , ("M-e", spawn "emacs")
         , ("M-S-y", spawn "ytfzf -D")
         , ("M-S-m", spawn "bookmarks")

         --- Go to last visited workspace
         , ("M-<Tab>", CWS.toggleWS)

         -- Layouts
         , ("M-s", withFocused toggleFloat)
         , ("M-d", sendMessage $ Toggle MIRROR)
         , ("M-m", sendMessage $ Toggle NBFULL)
         
         --- Go to workspace prompt
         , ("M-S-g", goToSelected def)
         , ("M-S-b", bringSelected def)
         
         , ("M-S-=", withFocused toggleBorder)
         ]
  where
    toggleFloat w = windows (\s -> if M.member w (W.floating s)
                                   then W.sink w s
                                   else (W.float w (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2)) s))
