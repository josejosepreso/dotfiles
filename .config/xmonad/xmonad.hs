------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
    -- Base
import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Utilities
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.Cursor
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

    -- Actions
import XMonad.Actions.Minimize (minimizeWindow)
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), shiftNextScreen, shiftPrevScreen, nextScreen, prevScreen) 
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize as Sqr
import qualified XMonad.Actions.CycleWS as CWS

    -- Layouts modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))

    -- Prompts
import XMonad.Prompt (XPConfig(..), XPPosition(Top), Direction1D(..))

------------------------------------------------------------------------
---CONFIG
------------------------------------------------------------------------
myFont          = "xft:0xProtoNerdFontMono-Regular:pixelsize=12"
myModMask       = mod4Mask  -- Sets modkey to super/windows key
myTerminal      = "alacritty"      -- Sets default terminal
myTextEditor    = "vim"     -- Sets default text editor
myBorderWidth   = 2         -- Sets border width for windows
myEmacs = "emacsclient -c -a ''"
windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

main :: IO ()
main = do
    -- Launching xmobar.
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobar.hs"
    xmonad $ ewmh desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x 
                        , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 70     -- Title of active window in xmobar
                        , ppSep =  "<fc=#9AEDFE> : </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        , modMask            = myModMask
        , terminal           = myTerminal
        , layoutHook         = myLayoutHook 
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        , startupHook = do
                  setDefaultCursor xC_left_ptr
                  spawnOnce "~/.fehbg &"
                  spawnOnce "picom"
                  spawn "usr/bin/emacs --daemon"
        } `additionalKeysP`         myKeys

       
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
    , gs_font         = myFont
    }
    
spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def

---------------------------------------------------------------------------------------------------------------------------
---WORKSPACES
---------------------------------------------------------------------------------------------------------------------------
xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myWorkspaces :: [String]
myWorkspaces = (map xmobarEscape) $ ["hom", "dev", "term", "doc", "git", "pt", "dos", "vid", "www"]

--------------------------------------------------------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
myKeys :: [(String, X ())]
myKeys =
    --- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                  -- Quits xmonad

    --- Brightness control
	, ("<XF86MonBrightnessUp>", spawn "brightnessctl set +3%")
	, ("<XF86MonBrightnessDown>", spawn "brightnessctl set 3%-")
	, ("S-<XF86MonBrightnessDown>", spawn "brightnessctl set 1%-")
	, ("S-<XF86MonBrightnessUp>", spawn "brightnessctl set +1%")

    --- Volume control
	, ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
	, ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
	, ("<XF86AudioMute>", spawn "amixer set Master toggle")

    --- mpc
        , ("<XF86AudioNext>", spawn "mpc next")
        , ("<XF86AudioPrev>", spawn "mpc prev")
        , ("<XF86AudioPlay>", spawn "mpc toggle")

    --- Screenshot
	, ("<Print>", spawn "scrot /home/jose/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png")
    
    --- Windows
        , ("M-w", kill1)                           -- Kill the currently focused client
        , ("M-S-a", killAll)                         -- Kill all the windows on current workspace

    --- Floating windows
        , ("M-<Delete>", withFocused $ windows . W.sink)  -- Push floating window back to tile.
        , ("M-S-<Delete>", sinkAll)                  -- Push ALL floating windows back to tile.

    --- Go to workspace prompt
        , ("M-S-g", goToSelected $ mygridConfig myColorizer)
        , ("M-S-b", bringSelected $ mygridConfig myColorizer)

    --- Windows navigation
        , ("M-m", windows W.focusMaster)             -- Move focus to the master window
        , ("M-j", windows W.focusDown)               -- Move focus to the next window
        , ("M-k", windows W.focusUp)                 -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)              -- Swap the focused window with the next window
        , ("M-S-k", windows W.swapUp)                -- Swap the focused window with the prev window
        , ("M-<Backspace>", promote)                 -- Moves focused window to master, all others maintain order
        , ("M-S-s", windows copyToAll)  
        , ("M-C-s", killAllOtherCopies) 
        
        , ("M-C-M1-<Up>", sendMessage Arrange)
        , ("M-C-M1-<Down>", sendMessage DeArrange)
        , ("M-<Up>", sendMessage (MoveUp 10))             --  Move focused window to up
        , ("M-<Down>", sendMessage (MoveDown 10))         --  Move focused window to down
        , ("M-<Right>", sendMessage (MoveRight 10))       --  Move focused window to right
        , ("M-<Left>", sendMessage (MoveLeft 10))         --  Move focused window to left
        , ("M-S-<Up>", sendMessage (IncreaseUp 10))       --  Increase size of focused window up
        , ("M-S-<Down>", sendMessage (IncreaseDown 10))   --  Increase size of focused window down
        , ("M-S-<Right>", sendMessage (IncreaseRight 10)) --  Increase size of focused window right
        , ("M-S-<Left>", sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
        , ("M-C-<Up>", sendMessage (DecreaseUp 10))       --  Decrease size of focused window up
        , ("M-C-<Down>", sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
        , ("M-C-<Right>", sendMessage (DecreaseRight 10)) --  Decrease size of focused window right
        , ("M-C-<Left>", sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left

    --- Layouts
        , ("M-<Space>", sendMessage NextLayout)                              -- Switch to next layout
	    , ("M-S-<Space>", sendMessage ToggleStruts)                          -- Toggles struts
	    , ("M-S-=", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

	    , ("M-C-h", sendMessage Shrink)
	    , ("M-C-l", sendMessage Expand)
	    , ("M-C-j", sendMessage MirrorShrink)
	    , ("M-C-k", sendMessage MirrorExpand)
	    , ("M-S-;", sendMessage zoomReset)
	    , ("M-;", sendMessage ZoomFullToggle)

	--- Workspaces
        , ("M-<Tab>", CWS.toggleWS)                        -- Go to last visited workspace

    --- Cycle through non empty workspaces
        , ("M-S-l", moveTo Next (Not CWS.emptyWS))
        , ("M-S-h", moveTo Prev (Not CWS.emptyWS))

    --- ranger
        , ("M-c", spawn "alacritty -e ranger")

    --- Scratchpads
        , ("M-v", namedScratchpadAction myScratchPads "ncmpcpp")
        , ("M-d", namedScratchpadAction myScratchPads "emacs")
        , ("M-S-<Return>", namedScratchpadAction myScratchPads "scratchpad")

    --- Open Terminal
        , ("M-<Return>", spawn myTerminal)
        ] where nonNSP          = WSIs (return (\ws -> W.tag ws /= "nsp"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))
                

myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [
        className =? "XCalc"        --> doFloat
      , className =? "mpv"          --> doShift "vid"
      , className =? "qutebrowser"  --> doShift "www"
      , className =? "librewolf-default"    --> doShift "www"
      , className =? "apadoc"       --> doShift "doc"
      -- , className =? "MuPDF"        --> doShift "doc"
     ] <+> namedScratchpadManageHook myScratchPads

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where 
                 myDefaultLayout = tall ||| Mirror tall  ||| floats  ||| noBorders monocle

tall       = renamed [Replace "tall"]     $ limitWindows 12 $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ ResizableTall 1 (3/100) (1/2) []
monocle    = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
space      = renamed [Replace "space"]    $ limitWindows 4  $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat


myScratchPads :: [NamedScratchpad]
myScratchPads = [
        NS "ncmpcpp" (myTerminal ++ " --class ncmpcpp -e ncmpcpp") (resource =? "ncmpcpp")
         (customFloating $ W.RationalRect (0.05) (0.05) (0.9) (0.9))
      , NS "emacs" ("emacsclient -c -a \"\"") (resource =? "emacs")
         (customFloating $ W.RationalRect (0.05) (0.05) (0.9) (0.9))
         --(nonFloating)
      , NS "scratchpad" (myTerminal ++ " --class scratchpad") (resource =? "scratchpad")
         (customFloating $ W.RationalRect (0.05) (0.05) (0.9) (0.9))
 ]
