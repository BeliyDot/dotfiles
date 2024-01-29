import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

main :: IO()
main = xmonad $ ewmhFullscreen $ ewmh $ withEasySB (statusBarProp "xmobar ~/.xmobarrc" (pure myXmobarPP)) defToggleStrutsKey $ def {
	terminal = "urxvt",
	borderWidth = 2, 
	focusedBorderColor = "#ffffff",
	startupHook = myStartupHook
}
 

myXmobarPP :: PP
myXmobarPP = def
    {	ppOrder = \(ws:_) -> [ws],
	ppCurrent = wrap " " "" . xmobarBorder "Bottom" "#ffffff" 2,
	ppHidden          = xmobarColor "#ffffff" "" . wrap " " "",
	ppHiddenNoWindows = xmobarColor "#aaaaaa" "" . wrap " " ""
}



ppWindow :: String -> String
ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

myStartupHook :: X()
myStartupHook = do
	spawnOnce "xrandr --output Virtual1 --mode 1920x1080"
	spawnOnce "feh --bg-fill --randomize ~/Wallpapers/*"
