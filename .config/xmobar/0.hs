Config { font = "Iosevka Bold 9"
       , bgColor = "#000000"
       , fgColor = "#B45BCF"
       , position = Top
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/jose/.config/xmobar/"
       , commands = [  Run Date "<fn=2>\xf073</fn>  %Y %b %d (%a) %I:%M%p" "date" 50
                    , Run Cpu ["-t", "<fn=2>\xf4bc</fn>  cpu: (<total>%)","-H","50","--high","red"] 60
                    , Run Memory ["-t", "<fn=2>\xefc5</fn>  mem: <used>M (<usedratio>%)"] 60
		    , Run DiskU [("/", "<fn=2>\xf0a23</fn>  sda3: <free> free")] [] 60
		    , Run BatteryP ["BAT0"] ["-t", "<acstatus><watts> (<left>%)"] 360
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       -- , template = " <fc=#ff6100>eDP1</fc> | %UnsafeStdinReader% }{ <fc=#c19898>%cpu%</fc> | <fc=#c19898>%memory%</fc> | <fc=#c19898>%disku%</fc> | <fc=#c19898>%date%</fc> | <fc=#c19898>%battery%</fc> "
       , template = " <icon=haskell_20.xpm/> | %UnsafeStdinReader% }{ <fc=#c19898>%cpu%</fc> | <fc=#c19898>%memory%</fc> | <fc=#c19898>%disku%</fc> | <fc=#c19898>%date%</fc> | <fc=#c19898>%battery%</fc> "
       }
