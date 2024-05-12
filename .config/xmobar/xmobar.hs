-- http://projects.haskell.org/xmobar/
-- install xmobar with these flags: --flags="with_alsa" --flags="with_mpd" --flags="with_xft"  OR --flags="all_extensions"
-- you can find weather location codes here: http://weather.noaa.gov/index.html

Config { font = "0xProtoNerd Font 7.85"
       , bgColor = "#282A36"
       , fgColor = "#B45BCF"
       , position = Top
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/jose/.config/xmonad/xpm/"  -- default: "."
       , commands = [  Run Date "<fn=2>\xf017</fn>  %b %d %Y - (%H:%M) " "date" 50
                    , Run Cpu ["-t", "<fn=2>\xf108</fn>  cpu: (<total>%)","-H","50","--high","red"] 60
                    , Run Memory ["-t", "<fn=2>\xf233</fn>  mem: <used>M (<usedratio>%)"] 60
		    , Run DiskU [("/", "<fn=2>\xf0c7</fn>  hdd: <free> free")] [] 60
		    , Run BatteryP ["BAT0"] ["-t", "<acstatus><watts> (<left>%)"] 360
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell_20.xpm/> <fc=#666666>|</fc> %UnsafeStdinReader% }{ <fc=#82AAFF>%cpu%</fc> <fc=#FF5555>%memory%</fc> <fc=#a9a1e1>%disku%</fc> <fc=#8BE9FD>%date%</fc> <fc=#FFB86C>%battery%</fc> "
       }
