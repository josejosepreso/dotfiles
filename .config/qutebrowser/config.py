config.load_autoconfig()

c.auto_save.session = True
c.content.images = False

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow locally loaded documents to access remote URLs.
# Type: Bool
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/jose/.local/share/qutebrowser/userscripts/*')

# Allow locally loaded documents to access other local URLs.
# Type: Bool
config.set('content.local_content_can_access_file_urls', False, 'file:///home/jose/.local/share/qutebrowser/userscripts/*')

c.content.notifications.enabled = False
c.content.autoplay = False
c.colors.webpage.darkmode.enabled = False
c.url.default_page="about:blank"
c.aliases={"o": "open"}
c.url.searchengines={
        "DEFAULT": "https://duckduckgo.com/lite/?q={}",
        "yt": "https://m.youtube.com/results?search_query={}",
        "aw": "https://wiki.archlinux.org/?search={}"
}

config.bind('I', 'set content.images true')
config.bind('Z', 'set content.images false')
config.bind('J', 'hint links spawn --detach mpv --ytdl-format=18 {hint-url}')

with config.pattern('*://play.pokemonshowdown.com/*') as p:
    p.content.images = True
