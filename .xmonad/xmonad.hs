import XMonad
import XMonad.Config.Desktop

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified XMonad.Actions.CycleWS as CWS
import qualified XMonad.StackSet as W
import XMonad.Actions.GridSelect
import XMonad.Actions.NoBorders

import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.WindowSwallowing

import qualified Data.Map as M
import Data.Ratio
import XMonad.ManageHook

baseConfig = desktopConfig {
  modMask = mod4Mask
  , focusedBorderColor = "#ffffff"
  , borderWidth = 1
  , layoutHook = myLayout
  , workspaces = ["hom", "dev", "term", "db", "git", "pt", "mus", "vid", "www"]
  , manageHook = myManageHook
  , startupHook = do
      -- spawnOnce "xsetroot -cursor_name left_ptr"
      spawnOnce "~/.fehbg"
      spawnOnce "xrdb ~/.Xresources"
      -- spawnOnce "xrandr --output HDMI2 --brightness 0.55"
      spawnOnce "xmodmap ~/.Xmodmap"
      spawnOnce "redshift -P -O 4000"
  } `additionalKeysP` myKeys `removeKeysP` [("M-<Space>")]


myLayout = mkToggle (single MIRROR)
	$ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
  $ avoidStruts
	$ spacingRaw True (Border 6 6 6 6) True (Border 4 4 4 4) True
  $ renamed [Replace "T"] tiled
    ||| renamed [Replace "M"] (Mirror tiled)
    ||| renamed [Replace "F"] Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1 / 2
    delta   = 3 / 100

myManageHook :: ManageHook
myManageHook = composeAll [ className =? "mpv" --> doShift "vid"
                          , className =? "qutebrowser" --> doShift "www"
                          , className =? "firefox" --> doShift "www"
                          ]
               
main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/0.hs"
  -- xmproc' <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/1.hs"
  xmonad $ docks $ baseConfig {
		handleEventHook = swallowEventHook (className =? "Alacritty") (return True) <+> handleEventHook baseConfig
	, logHook = dynamicLogWithPP xmobarPP
              { ppOutput = \x -> hPutStrLn xmproc x -- >> hPutStrLn xmproc' x
              , ppCurrent = xmobarColor "#c19898" "" . wrap "[" "]"
              , ppVisible = xmobarColor "#747474" ""
              , ppHidden = xmobarColor "#a9b7ff" "" . wrap "*" ""
              , ppHiddenNoWindows = xmobarColor "#ffffff" ""
							, ppLayout = xmobarColor "#ffcc00" ""
              , ppTitle = xmobarColor "#98c379" "" . shorten 50
              , ppSep = "<fc=#9AEDFE> : </fc>"
              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
              -- , ppExtras  = [windowCount]
              , ppOrder = \(ws:l:t:ex) -> [ws, l] ++ ex ++ [t]
              }
    }

myKeys :: [(String, X ())]
myKeys = [ ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
         , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
         , ("<XF86AudioMute>", spawn "amixer set PCM toggle")
         
         -- , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +3%")
         -- , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 3%-")
         
         -- , ("<XF86AudioNext>", spawn "mpc next")
         -- , ("<XF86AudioPrev>", spawn "mpc prev")
         -- , ("<XF86AudioPlay>", spawn "mpc toggle")
         
         --- Screenshot
         , ("<Print>", spawn "scrot")
         
         --- Open Terminal
         , ("M-<Return>", spawn myTerminal)

				 -- rofi
         , ("M-S-<Return>", spawn "rofi -show drun")
         , ("M-S-b", spawn "keetype")

				 -- dmenu
         -- , ("M-p", spawn "dmenu_run -fn Iosevka:style=Bold:size=9 -nb #000000 -nf #bbbbbb -sb #986c5b -sf #eeeeee")
         , ("M-p", spawn "dmenu_run -fn 'Iosevka:style=Bold:size=9' -nb '#000000' -nf '#bbbbbb' -sb '#986c5b' -sf '#eeeeee'")
         
         --- Kill window
         , ("M-S-c", kill)
         
         -- , ("M-c", spawn "st -e ncmpcpp")
         , ("M-v", spawn $ myTerminal ++ " -e ranger")
         , ("M-e", spawn "emacs")
         -- , ("M-S-y", spawn "ytfzf -D")
         -- , ("M-S-m", spawn "bookmarks")

         --- Go to last visited workspace
         , ("M1-<Tab>", CWS.toggleWS)

         -- Layouts
         , ("M-s", withFocused toggleFloat)
         , ("M-d", sendMessage $ Toggle MIRROR)
         , ("M-m", sendMessage $ Toggle NBFULL)
         
         --- Go to workspace prompt
         , ("M-S-g", goToSelected def)
         -- , ("M-S-b", bringSelected def)
         
         , ("M-S-=", withFocused toggleBorder)

				 -- zoom
				 , ("M-S-m", windows W.swapMaster)

				 , ("M-]", CWS.moveTo Next $ CWS.Not CWS.emptyWS)
				 , ("M-[",  CWS.moveTo Prev $ CWS.Not CWS.emptyWS)
         ]
  where
    toggleFloat w = windows (\s -> if M.member w (W.floating s)
                                   then W.sink w s
                                   else (W.float w (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2)) s))

myTerminal :: String
myTerminal = "alacritty"
