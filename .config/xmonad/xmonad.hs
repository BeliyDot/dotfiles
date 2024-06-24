import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.Hacks (fixSteamFlicker)

import Graphics.X11.ExtraTypes.XF86

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.VoidBorders

main :: IO()
main = xmonad $ ewmhFullscreen $ ewmh $ withEasySB (statusBarProp "xmobar ~/.config/xmobar/.xmobarrc" (clickablePP myXmobarPP)) defToggleStrutsKey $ docks $ def {
	terminal = "kitty",
	borderWidth = 2, 
	focusedBorderColor = "#ffffff",
	normalBorderColor = "#000000",
	modMask = mod4Mask,
	layoutHook = myLayout,
	manageHook = myManageHook,
	startupHook = myStartup,
  handleEventHook = fixSteamFlicker
}
   `additionalKeysP`
     [ ("M-f", spawn "firefox"),
	("M-e", spawn "kitty lfrun"),
	("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 5%-"),
	("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 5%+"),
	("<XF86AudioMute>", spawn "amixer -D pulse sset Master toggle"),
	("<XF86MonBrightnessUp>", spawn "brillo -q -u 150000 -A 5"),
	("<XF86MonBrightnessDown>", spawn "brillo -q -u 150000 -U 5"),
	("<XF86AudioPlay>", spawn "playerctl play-pause"),
	("<XF86AudioPrev>", spawn "playerctl previous"),
	("<XF86AudioNext>", spawn "playerctl next"),
	("<XF86AudioStop>", spawn "playerctl stop"),
	("<XF86Calculator>", spawn "galculator"),
	("<Print>", spawn "gscreenshot -f $HOME/Pictures/Screenshots -c -s -n"),
	("S-<Print>", spawn "gscreenshot -f $HOME/Pictures/Screenshots -c -n"),
	("M-S-l", spawn "betterlockscreen -l --show-layout"),
	("M-o", spawn "rofi -show drun"),
	("M-w", spawn "rofi -show window"),
	("M-d", spawn "discord"),
	("M-b", sendMessage ToggleStruts),
	("M-s", spawn "steam"),
	("M-S-s", spawn "steam -bigpicture"),
	("M-i", spawn "kitty btop"),
	("M-p", spawn "rofi -show run"),
	("M-;", spawn "feh --bg-fill --randomize ~/Wallpapers/*"),
	("M-z", spawn "boomer"),
	("M-S-b", spawn "kitty bluetuith")
 ]
 
myManageHook :: ManageHook 
myManageHook = composeAll     
	[ className =? "Gimp" --> doFloat
	, isDialog            --> doFloat
	, appName =? "Toolkit" --> doFloat
	, title =? "Friends List" --> doFloat
	, title =? "Медіапереглядач" --> doFloat
	, className =? "overskride" --> doFloat
	, className =? "pavucontrol" --> doFloat
	, className =? "steam" --> doFloat
	, className =? "speed.exe" --> doFloat
	, className =? "feh" --> doFloat
	, className =? "kdenlive" --> doFloat
	, className =? "Galculator" --> doFloat
	, className =? "mpv" --> doFloat
	, className =? "Soffice" --> doFloat
	, className =? "VirtualBox Machine" --> doFloat
	, className =? "gamescope" --> doFloat
  , appName =? "Godot_Engine" --> doFloat
	] 

myLayout = spacing 3 $ avoidStruts $ ( smartBorders tiled ||| smartBorders (Mirror tiled) ||| voidBorders Full)
   where
	tiled = Tall 1 (3/100) (1/2)
myXmobarPP :: PP
myXmobarPP = def
    {	ppOrder = \(ws:_) -> [ws],
	ppCurrent = wrap " " "" . xmobarBorder "Bottom" "#ffffff" 2,
	ppHidden          = xmobarColor "#ffffff" "" . wrap " " "",
	ppHiddenNoWindows = xmobarColor "#aaaaaa" "" . wrap " " ""
}

myStartup :: X()
myStartup = do
	spawnOnce "fusuma"
	spawnOnce "redshift"
