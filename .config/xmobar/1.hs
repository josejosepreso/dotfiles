Config { font = "Iosevka Bold 9"
       , bgColor = "#000000"
       , fgColor = "#B45BCF"
       , position = Top
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , commands = [Run UnsafeStdinReader]
       , iconRoot = "/home/jose/.config/xmobar/"
       -- , template = " <fc=#ff6100>HDMI2</fc> | %UnsafeStdinReader%"
       , template = " <icon=haskell_20.xpm/> | %UnsafeStdinReader%"
       }
