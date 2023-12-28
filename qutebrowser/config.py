config.load_autoconfig(False) # DO not load autoconfig.yml
# aliases
c.aliases = {'w': 'session-save', 'q': 'close', 'qa': 'quit', 'wq': 'quit --save', 'wqa': 'quit --save', 'gl': 'open -t http://127.0.0.1:4000'}

# General
c.auto_save.interval = 150
c.auto_save.session = True
c.session.default_name = "inogen"
c.backend = 'webengine' # webengine (chromium), webkit
c.bindings.key_mappings = {'<Ctrl-[>': '<Escape>', '<Ctrl-6>': '<Ctrl-^>', '<Ctrl-M>': '<Return>', '<Ctrl-J>': '<Return>', '<Ctrl-I>': '<Tab>', '<Shift-Return>': '<Return>', '<Enter>': '<Return>', '<Shift-Enter>': '<Return>', '<Ctrl-Enter>': '<Ctrl-Return>'}
c.colors.webpage.preferred_color_scheme = 'dark' # dark, light, auto
c.completion.height = '40%'

# Ads blocking
c.content.blocking.adblock.lists = ["https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-others.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2022.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2023.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-mobile.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/ubol-filters.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt", "https://easylist.to/easylist/easylist.txt", "https://easylist.to/easylist/easyprivacy.txt"]
c.content.blocking.enabled = True
c.content.blocking.hosts.block_subdomains = True
c.content.blocking.hosts.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']
c.content.blocking.method = 'both' # auto, hosts, adblock, both

# Permission
c.content.autoplay = False
c.content.cache.appcache = True
c.content.mute = False
c.content.notifications.enabled = False
c.content.geolocation = False
c.content.persistent_storage = 'ask'
c.content.webrtc_ip_handling_policy = 'default-public-interface-only' # all-interfaces,default-public-and-private-interfaces, default-public-interface-only, disable-non-proxied-udp
c.content.webgl = True
c.content.canvas_reading = True
c.content.cookies.accept = 'no-3rdparty' # all, no-3rdparty, no-unknown-3rdparty, never
# c.content.media.audio_capture = 'ask'
# c.content.media.audio_video_capture = 'ask'
# c.content.media.video_capture = 'ask'
# c.content.mouse_lock = 'ask'

# Other settings
c.content.headers.do_not_track = True
c.content.cache.maximum_pages = 2
c.content.cookies.store = True
c.content.dns_prefetch = True
c.content.headers.user_agent = 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}'
c.content.pdfjs = True
c.content.print_element_backgrounds = True
# c.content.proxy = 'system'
c.content.register_protocol_handler = False
c.search.ignore_case = 'always' # always, never, smart
c.search.incremental = True

# Downloads setting
c.downloads.location.directory = None
c.downloads.location.prompt = True
c.downloads.location.remember = True
c.downloads.prevent_mixed_content = True
c.downloads.remove_finished = 20000

# Tabs setting
c.tabs.close_mouse_button = 'none'
c.tabs.mousewheel_switching = False
c.tabs.show = 'multiple' # always, never, multiple, switching
c.tabs.show_switching_delay = 100
c.tabs.title.format = '{audio}{index}: {current_title}'
c.tabs.title.format_pinned = '[P] {index}'
c.tabs.width = '15%'
c.url.default_page = 'https://start.duckduckgo.com/'

# Search Engine
c.url.searchengines['DEFAULT'] = 'https://duckduckgo.com/?q={}'
c.url.searchengines['w'] = 'https://wiki.archlinux.org/?search={}'
c.url.searchengines['y'] = 'https://yewtu.be/search?q={}'
c.url.start_pages = ['https://start.duckduckgo.com']

# Decoration
c.window.hide_decoration = False
c.window.title_format = '{perc}{current_title}'
c.zoom.default = '90%'
c.editor.command = ['nvim', '-f', '{file}', '-c', 'normal {line}G{column0}l']
c.qt.chromium.process_model = 'process-per-site-instance' #process-per-site-instance, process-per-site
c.qt.chromium.sandboxing = 'enable-all' #enable-all, disable-seccomp-bpf
# c.session.lazy_restore = True
# c.spellcheck.languages = ['en-GB', 'en-US']
c.statusbar.widgets = ['keypress', 'search_match', 'url', 'scroll', 'history', 'tabs', 'progress']

# Bindings for normal mode
config.bind('<Ctrl-r>', 'restart', mode='normal')
config.bind('<Ctrl-Shift-Right>', 'tab-move +', mode='normal')
config.bind('<Ctrl-Shift-Left>', 'tab-move -', mode='normal')
config.bind('<Ctrl-Right>', 'tab-next', mode='normal')
config.bind('<Ctrl-Left>', 'tab-prev', mode='normal')
config.bind('ah', 'back', mode='normal')
config.bind('al', 'forward', mode='normal')
config.bind('am', 'spawn mpv {url}', mode='normal')
config.bind('ap', 'cmd-set-text -s :open -p', mode='normal')
config.bind('at', 'cmd-set-text -s :open -t', mode='normal')

# Bindings for command mode
config.bind('jj', 'mode-leave', mode='command')

# Bindings for hint mode
config.bind('jj', 'mode-leave', mode='hint')

# Bindings for passthrough mode
config.bind('jj', 'mode-leave', mode='passthrough')

# Bindings for register mode
config.bind('jj', 'mode-leave', mode='register')

# Bindings for yesno mode
config.bind('jj', 'mode-leave', mode='yesno')


