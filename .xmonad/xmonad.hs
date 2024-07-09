import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import qualified XMonad.Actions.CycleWS as CWS -- Last visited workspace
import qualified XMonad.StackSet as W          -- Set master
import XMonad.Actions.CycleWS                  -- Cycle through workspaces
import XMonad.Actions.GridSelect               -- Grid prompt
import XMonad.Actions.NoBorders
import XMonad.Hooks.WindowSwallowing

baseConfig = desktopConfig {
               modMask = mod4Mask
             , focusedBorderColor = "#bbc5ff"
             , borderWidth        = 2
            }

main :: IO ()
main = xmonad $ baseConfig {
                  startupHook = startupHook baseConfig <+> idHook
                , handleEventHook = swallowEventHook (className =? "URxvt") (return True) 
               }
                `additionalKeysP` myKeys

myKeys :: [(String, X ())]
myKeys = [ 
                 --- Volume control
                 ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
               , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
               , ("<XF86AudioMute>", spawn "amixer set Master toggle")
               
               , ("<XF86AudioPlay>", spawn "mocp -G")
               , ("<XF86AudioNext>", spawn "mocp -f")
               , ("<XF86AudioPrev>", spawn "mocp -r")

                 --- Screenshot
               , ("<Print>", spawn "scrot /home/jose/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png")
                
                 --- Open Terminal
               , ("M-<Return>", spawn "urxvt")

                 --- Kill window
               , ("M-w", kill)
               
                 ---
               -- , ("M-c", spawn "urxvt -e mocp")
               , ("M-c", spawn "urxvt -e mocp")
               , ("M-v", spawn "urxvt -e ranger")
               , ("M-m", spawn "mplay")
               , ("M-e", spawn "emacsclient -c -a ''")
               , ("M-S-y", spawn "ytfzf -D")

                 --- Swap the focused window and the master window
               , ("M-S-m", windows W.swapMaster)

                 --- Go to last visited workspace
               , ("M-<Tab>", CWS.toggleWS)

                 --- Cycle through non empty workspaces
               -- , ("M-S-l", moveTo Next (Not emptyWS))
               , ("M-S-<Space>", moveTo Next (Not emptyWS))
               -- , ("M-S-h", moveTo Prev (Not emptyWS))

                 --- Go to workspace prompt
               , ("M-S-g", goToSelected def)
               , ("M-S-b", bringSelected def)

               , ("M-S-=", withFocused toggleBorder)
 ]
