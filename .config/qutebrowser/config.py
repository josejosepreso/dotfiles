config.load_autoconfig()

c.auto_save.session = True
c.content.images = True

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome://*/*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow locally loaded documents to access remote URLs.
# Type: Bool
config.set("content.local_content_can_access_remote_urls", True, "file:///home/jose/.local/share/qutebrowser/userscripts/*")

# Allow locally loaded documents to access other local URLs.
# Type: Bool
config.set("content.local_content_can_access_file_urls", False, "file:///home/jose/.local/share/qutebrowser/userscripts/*")

c.tabs.show = "multiple"
c.tabs.favicons.show = "always"
c.tabs.position ="top"

c.tabs.title.format = "{audio}{current_title}"

config.bind("tt", "set tabs.show multiple")
config.bind("tT", "set tabs.show never")
config.bind("th", "set tabs.position left")
config.bind("tk", "set tabs.position top")

c.content.notifications.enabled = False
c.content.autoplay = False
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
# c.url.default_page="about:blank"
c.url.default_page="file:///home/jose/.config/qutebrowser/home.html"
c.aliases={"o": "open", "q": "quit"}
c.url.searchengines={
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "yt": "https://m.youtube.com/results?search_query={}",
        "aw": "https://wiki.archlinux.org/?search={}",
        "hs": "https://hoogle.haskell.org/?hoogle={}",
        "gpt": "https://chat.openai.com/?q={}"
}
c.content.blocking.method = 'adblock'
config.bind("I", "adblock-update")
config.bind("J", "hint links userscript yt_mpv")

#
config.bind("<z><l>", "spawn --userscript qute-pass")
config.bind("<z><u><l>", "spawn --userscript qute-pass --username-only")
config.bind("<z><p><l>", "spawn --userscript qute-pass --password-only")
config.bind("<z><o><l>", "spawn --userscript qute-pass --otp-only")

config.source("gruvbox.py")
