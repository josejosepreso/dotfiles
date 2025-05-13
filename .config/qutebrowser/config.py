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

c.content.notifications.enabled = False
c.content.autoplay = False
c.colors.webpage.darkmode.enabled = False
c.url.default_page="about:blank"
c.aliases={"o": "open", "q": "quit"}
c.url.searchengines={
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "yt": "https://m.youtube.com/results?search_query={}",
        "aw": "https://wiki.archlinux.org/?search={}",
        "hs": "https://hoogle.haskell.org/?hoogle={}"
}
c.content.blocking.method = 'adblock'
config.bind("I", "adblock-update")
# config.bind("J", "hint links spawn --detach mpv {hint-url}")
config.bind("J", "hint links userscript yt_mpv")

c.tabs.title.format = "{audio}{current_title}"

#
config.bind("<z><l>", "spawn --userscript qute-pass")
config.bind("<z><u><l>", "spawn --userscript qute-pass --username-only")
config.bind("<z><p><l>", "spawn --userscript qute-pass --password-only")
config.bind("<z><o><l>", "spawn --userscript qute-pass --otp-only")

with config.pattern("*://open.spotify.com/*") as p:
    p.content.images = False
