import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import qualified XMonad.Actions.CycleWS as CWS -- Last visited workspace
import qualified XMonad.StackSet as W
import XMonad.Actions.GridSelect               -- Grid prompt
import XMonad.Actions.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import qualified Data.Map as M
import Data.Ratio
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.ManageHook
import Keys

baseConfig = desktopConfig {
  modMask = mod4Mask
  , focusedBorderColor = "#ffffff"
  , borderWidth = 1
  , layoutHook = myLayout
  , workspaces = ["hom", "dev", "term", "doc", "git", "pt", "dos", "vid", "www"]
  , manageHook = myManageHook
  , startupHook = do
      spawnOnce "xsetroot -cursor_name left_ptr"
      spawnOnce "~/.fehbg &"
      spawnOnce "xrdb ~/.Xresources"
      spawnOnce "xrandr --output HDMI2 --brightness 0.55"
  } `additionalKeysP` myKeys `removeKeysP` [("M-<Space>")]

myLayout = avoidStruts
           $ mkToggle (single MIRROR)
           $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
           $ spacing 3 tiled ||| Mirror tiled ||| Full
  where tiled   = Tall nmaster delta ratio
        nmaster = 1      -- Default number of windows in the master pane
        ratio   = 1/2    -- Default proportion of screen occupied by master pane
        delta   = 3/100  -- Percent of screen to increment by when resizing panes

myManageHook :: ManageHook
myManageHook = composeAll [ className =? "mpv" --> doShift "vid"
                          , className =? "qutebrowser" --> doShift "www"
                          , className =? "LibreWolf" --> doShift "www"
                          ]
               
main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/0.hs"
  xmproc' <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/1.hs"
  xmonad $ docks $ baseConfig {
    logHook = dynamicLogWithPP xmobarPP
              { ppOutput = \x -> hPutStrLn xmproc x >> hPutStrLn xmproc' x
              , ppCurrent = xmobarColor "#c19898" "" . wrap "[" "]"
              , ppVisible = xmobarColor "#747474" ""
              , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""
              , ppHiddenNoWindows = xmobarColor "#ffffff" ""
              , ppTitle = xmobarColor "#c19898" "" . shorten 40
              , ppSep = "<fc=#9AEDFE> : </fc>"
              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
              , ppExtras  = [windowCount]
              , ppOrder  = \(ws:l:t:ex) -> [ws, l] ++ ex ++ [t]
              }
    }
