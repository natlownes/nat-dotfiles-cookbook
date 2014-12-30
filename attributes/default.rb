override[:srcinstall][:builddir] = '/tmp/build'

default[:nat][:packages] = %w(
  autossh
  bash-completion
  keychain
  sshfs
  tcpdump
  tig
  tmux
  whois
  zsh
)

default[:nat]['linux'][:packages] = %w(
  apache2-utils
  build-essential
  curl
  dnsutils
  encfs
  exuberant-ctags
  hfsplus
  hfsprogs
  hfsutils
  htop
  libpam-encfs
  mercurial
  protobuf-compiler
  ruby
  ruby-dev
  wget
)

default[:nat]['darwin'][:packages] = %w(
  ctags
  ruby19
)

default[:nat][:the_silver_searcher]['darwin'][:build_dependencies] = %w(
  automake
  pcre
  pkgconfig
)

default[:nat][:the_silver_searcher]['linux'][:build_dependencies] = %w(
  automake
  liblzma-dev
  libpcre3-dev
  pkg-config
  zlib1g-dev
)

default[:nat][:the_silver_searcher][:scm_url] =
  'https://github.com/ggreer/the_silver_searcher.git'

default[:nat][:metal][:packages] = %w(
  ario
  audacity
  autofs
  chromium-browser
  claws-mail
  conky
  feh
  flashplugin-downloader
  flashplugin-installer
  gimp
  gmpc
  gnupg-agent
  imagemagick
  keepassx
  kpcli
  lame
  libpq-dev
  libqt4-sql-psql
  liferea
  mediainfo
  mediainfo-gui
  mplayer
  mtpfs
  ncmpc
  ncmpcpp
  parcellite
  pidgin
  postgresql-client
  powernap
  python-qt4
  python-qt4-sql
  rxvt-unicode-256color
  shutter
  stterm
  vlc
  weechat-curses
  xautomation
  xbacklight
  xbindkeys
  zim
)

# force_install == blow away src dir
default[:nat][:tmux][:force_install]      = false
default[:nat][:tmux][:source_url]         = 'https://dl.dropboxusercontent.com/u/31982598/tmux-1.9a.tar.gz'
default[:nat][:tmux]['linux'][:build_dependencies] = %w(
  libevent-dev
  libncurses5-dev
)
default[:nat][:tmux]['darwin'][:build_dependencies] = %w(
  libevent
  ncurses
)

default[:nat][:weechat][:src_url]            = 'http://www.weechat.org/files/src/weechat-0.4.2.tar.bz2'
default[:nat][:weechat][:build_dependencies] = %w(
  build-essential
  ca-certificates
  cmake
  gettext
  libaspell-dev
  libcurl4-gnutls-dev
  libgcrypt11-dev
  libgnutls-dev
  liblua5.1-0-dev
  libncursesw5-dev
  libperl-dev
  python-dev
  ruby1.9.1-dev
  tcl-dev
  zlib1g-dev
)

default[:nat][:weechat][:plugins] = [
  {'path' => '.weechat/python/growl.py',   'url' => 'http://weechat.org/files/scripts/growl.py'},
  {'path' => '.weechat/python/jabber.py',  'url' => 'http://weechat.org/files/scripts/jabber.py'},
  {'path' => '.weechat/python/shell.py',   'url' => 'http://weechat.org/files/scripts/shell.py'},
  {'path' => '.weechat/python/themes.py',  'url' => 'http://weechat.org/files/scripts/tinyurl.py'},
  {'path' => '.weechat/python/tinyurl.py', 'url' => 'http://weechat.org/files/scripts/tinyurl.py'},
]

# ssh
#
# client hostnames are the clients that should
# autossh to the host
# portmap is host => client
#
default[:nat][:ssh] = {
  :auto_ssh_key_path => 'Dropbox-sec/keys/doublev.int.vistarmedia.com',
  :client_hostnames => %w(
    doublev
  ),
  :server_hostname => 'slab.phl.looting.biz',
  :port_map => {
    22222 => 22
  }
}

default[:nat][:xterm][:font_packages] = %w(
  fonts-inconsolata
  xfonts-terminus
)

default[:nat][:wmii][:force_install] = false

default[:nat][:wmii][:build_dependencies] = [
  {:name => 'libxft-dev'},
  {:name => 'libxft2'},
  {:name => 'libx11-dev'},
  {:name => 'libxext-dev'},
  {:name => 'libxt-dev'},
  {:name => 'libxrandr-dev'},
  {:name => 'libxinerama-dev'},
  {:name => 'libxrender-dev'}
]

default[:nat][:wmii][:source_url] = 'http://dl.suckless.org/wmii/wmii+ixp-3.9b1.tbz'

default[:nat][:ruby][:rbenv][:scm_url]           = 'https://github.com/sstephenson/rbenv.git'
default[:nat][:ruby][:rbenv][:install_path]      = '.rbenv'
default[:nat][:ruby][:ruby_build][:scm_url]      = 'https://github.com/sstephenson/ruby-build.git'
default[:nat][:ruby][:ruby_build][:install_path] = '.rbenv/plugins/ruby-build'

default[:nat][:gem_packages] = [
  {'name' => 'gist'}
]

default[:nat][:golang][:scm_url]       = 'https://code.google.com/p/go'
default[:nat][:golang][:install_path]  = 'src/golang'
default[:nat][:golang][:force_install] = false

default[:nat][:music_player_client][:gateway][:host] = 'slab.phl.looting.biz'
default[:nat][:music_player_client][:server][:host]           = '10.30.5.101'
default[:nat][:music_player_client][:server][:port]           = 6600
default[:nat][:music_player_client][:server][:port_streaming] = 8000
default[:nat][:music_player_client][:local][:port]            = 6600
default[:nat][:music_player_client][:local][:port_streaming]  = 8991
default[:nat][:music_player_client][:cache_size]              = 512

default[:nat][:mpdscribble][:username]   = 'crabwhittaker'
default[:nat][:mpdscribble][:password]   = 'd2ddc99cdef1151d13b717b2ec7faad2'
default[:nat][:mpdscribble][:mpd][:host] = 'localhost'
default[:nat][:mpdscribble][:mpd][:port] = '6600'


default[:nat][:browser][:package_path] = 'Downloads'
default[:nat][:browser][:default]      = 'firefox'

default[:nat][:dropbox][:force_install] = false


default[:nat][:vim][:plugins] = [
  {'path'=>'.vim/autoload/vim-pathogen', 'url'=>'git://github.com/tpope/vim-pathogen.git'},

  {'path'=>'.vim/bundle/ag.vim', 'url'=>'git://github.com/rking/ag.vim.git'},
  {'path'=>'.vim/bundle/ctrl-p.vim', 'url'=>'git://github.com/kien/ctrlp.vim.git'},
  {'path'=>'.vim/bundle/fugitive', 'url'=>'git://github.com/tpope/vim-fugitive.git'},
  {'path'=>'.vim/bundle/neocomplcache', 'url'=>'https://github.com/Shougo/neocomplcache.vim.git'},
  {'path'=>'.vim/bundle/nerdtree', 'url'=>'git://github.com/scrooloose/nerdtree.git'},
  {'path'=>'.vim/bundle/python-mode', 'url'=>'git://github.com/klen/python-mode.git'},
  {'path'=>'.vim/bundle/supertab', 'url'=>'git://github.com/ervandew/supertab.git'},
  {'path'=>'.vim/bundle/syntastic', 'url'=>'https://github.com/scrooloose/syntastic.git'},
  {'path'=>'.vim/bundle/vim-addon-mw-utils', 'url'=>'git://github.com/MarcWeber/vim-addon-mw-utils.git'},
  {'path'=>'.vim/bundle/vim-async-command', 'url'=>'git://github.com/pydave/AsyncCommand.git'},
  {'path'=>'.vim/bundle/vim-clojure-static', 'url'=>'git://github.com/guns/vim-clojure-static.git'},
  {'path'=>'.vim/bundle/vim-coffee-script', 'url'=>'git://github.com/kchmck/vim-coffee-script.git'},
  {'path'=>'.vim/bundle/vim-colors-solarized', 'url'=>'git://github.com/altercation/vim-colors-solarized.git'},
  {'path'=>'.vim/bundle/vim-cucumber', 'url'=>'git://github.com/tpope/vim-cucumber.git'},
  {'path'=>'.vim/bundle/vim-easygrep', 'url'=>'git://github.com/vim-scripts/EasyGrep.git'},
  {'path'=>'.vim/bundle/vim-elixir', 'url'=>'git://github.com/elixir-lang/vim-elixir.git'},
  {'path'=>'.vim/bundle/vim-fakeclip', 'url'=>'git://github.com/kana/vim-fakeclip.git'},
  {'path'=>'.vim/bundle/vim-flake8', 'url'=>'https://github.com/nvie/vim-flake8.git'},
  {'path'=>'.vim/bundle/vim-foreplay', 'url'=>'git://github.com/tpope/vim-foreplay.git'},
  {'path'=>'.vim/bundle/vim-git', 'url'=>'https://github.com/tpope/vim-git.git'},
  {'path'=>'.vim/bundle/vim-gitsessions', 'url'=>'https://github.com/wting/gitsessions.vim.git'},
  {'path'=>'.vim/bundle/vim-gocode', 'url'=>'https://github.com/Blackrush/vim-gocode.git'},
  {'path'=>'.vim/bundle/vim-golang', 'url'=>'https://github.com/jnwhiteh/vim-golang.git'},
  {'path'=>'.vim/bundle/vim-haml', 'url'=>'git://github.com/tpope/vim-haml.git'},
  {'path'=>'.vim/bundle/vim-html5', 'url'=>'git://github.com/othree/html5.vim.git'},
  {'path'=>'.vim/bundle/vim-jade', 'url'=>'git://github.com/digitaltoad/vim-jade.git'},
  {'path'=>'.vim/bundle/vim-latex-live-preview', 'url'=>'git://github.com/xuhdev/vim-latex-live-preview.git'},
  {'path'=>'.vim/bundle/vim-less', 'url'=>'https://github.com/groenewege/vim-less.git'},
  {'path'=>'.vim/bundle/vim-literate-coffeescript', 'url'=>'https://github.com/mintplant/vim-literate-coffeescript.git'},
  {'path'=>'.vim/bundle/vim-markdown', 'url'=>'git://github.com/tpope/vim-markdown.git'},
  {'path'=>'.vim/bundle/vim-nerdcommenter', 'url'=>'git://github.com/scrooloose/nerdcommenter.git'},
  {'path'=>'.vim/bundle/vim-powerline-1', 'url'=>'git://github.com/Lokaltog/vim-powerline.git', 'branch' => 'develop'},
  {'path'=>'.vim/bundle/vim-protobuf-syntax', 'url'=>'git://github.com/jdevera/vim-protobuf-syntax.git'},
  {'path'=>'.vim/bundle/vim-ragtag', 'url'=>'git://github.com/tpope/vim-ragtag.git'},
  {'path'=>'.vim/bundle/vim-rails', 'url'=>'git://github.com/tpope/vim-rails.git'},
  {'path'=>'.vim/bundle/vim-rainbow-parenthesis', 'url'=>'git://github.com/kien/rainbow_parentheses.vim.git'},
  {'path'=>'.vim/bundle/vim-rspec', 'url'=>'https://github.com/thoughtbot/vim-rspec.git'},
  {'path'=>'.vim/bundle/vim-scala', 'url'=>'https://github.com/derekwyatt/vim-scala.git'},
  {'path'=>'.vim/bundle/vim-snippets', 'url'=>'git://github.com/garbas/vim-snipmate.git'},
  {'path'=>'.vim/bundle/vim-stylus', 'url'=>'https://github.com/wavded/vim-stylus.git'},
  {'path'=>'.vim/bundle/vim-surround', 'url'=>'git://github.com/tpope/vim-surround.git'},
  {'path'=>'.vim/bundle/vim-tabular', 'url'=>'git://github.com/godlygeek/tabular.git'},
  {'path'=>'.vim/bundle/vim-tagbar', 'url'=>'git://github.com/majutsushi/tagbar.git'},
  {'path'=>'.vim/bundle/vim-tbone', 'url'=>'git://github.com/tpope/vim-tbone.git'},
  {'path'=>'.vim/bundle/vim-tlib', 'url'=>'git://github.com/tomtom/tlib_vim.git'},
  {'path'=>'.vim/bundle/vim-tmux-navigator', 'url'=>'git://github.com/christoomey/vim-tmux-navigator.git'},
  {'path'=>'.vim/bundle/vim-tslime', 'url'=>'git://github.com/jgdavey/tslime.vim.git'},

  # colors i.e. http://www.youtube.com/watch?v=KP0OaUOQGCg
  {'path'=>'.vim/bundle/vim-vividchalk', 'url'=>'git://github.com/tpope/vim-vividchalk.git'},
  {'path'=>'.vim/colors/vim-luna', 'url'=>'git://github.com/Pychimp/vim-luna.git'}
]


default[:nat][:vim][:plugins_to_remove] = [
   {'path'=>'.vim/bundle/vim-ack', 'url'=>'git://github.com/mileszs/ack.vim.git'},
   {'path'=>'.vim/bundle/vim-matchit', 'url'=>'git://github.com/tsaleh/vim-matchit.git'}
]
