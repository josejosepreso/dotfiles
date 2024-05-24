import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import qualified XMonad.Actions.CycleWS as CWS -- Last visited workspace
import qualified XMonad.StackSet as W          -- Set master
import XMonad.Layout.Spacing                   -- Window spacing
import XMonad.Actions.CycleWS                  -- Cycle through workspaces
import XMonad.Actions.GridSelect

baseConfig = desktopConfig {
               modMask = mod4Mask
             , focusedBorderColor = "#bbc5ff"
             , borderWidth        = 2
            }

main :: IO ()
main = xmonad $ baseConfig {
                  startupHook = startupHook baseConfig <+> idHook
                , layoutHook = spacingWithEdge 3 $ layoutHook baseConfig
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
               , ("M-c", spawn "urxvt -e mocp")
               , ("M-v", spawn "urxvt -e ranger")
               , ("M-m", spawn "mplay")
               , ("M-e", spawn "emacsclient -c -a ''")

                 --- Swap the focused window and the master window
               , ("M-S-m", windows W.swapMaster)

                 --- Go to last visited workspace
               , ("M-<Tab>", CWS.toggleWS)

                 --- Cycle through non empty workspaces
               , ("M-S-l", moveTo Next (Not emptyWS))
               , ("M-S-h", moveTo Prev (Not emptyWS))

                 --- Go to workspace prompt
               , ("M-S-g", goToSelected $ mygridConfig myColorizer)
               , ("M-S-b", bringSelected $ mygridConfig myColorizer)
 ]

       
------------------------------------------------------------------------
---GRID SELECT
------------------------------------------------------------------------
myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x31,0x2e,0x39) -- lowest inactive bg
                  (0x31,0x2e,0x39) -- highest inactive bg
                  (0x61,0x57,0x72) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0xff,0xff,0xff) -- active fg
                  
-- gridSelect menu layout
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 30
    , gs_cellwidth    = 200
    , gs_cellpadding  = 8
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    --, gs_font         = myFont
    }
    
spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def


