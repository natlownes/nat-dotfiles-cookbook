default[:nat][:packages] = %w(
  autossh
  bash-completion
  sshfs
  tig
  tmux
  zsh
)

default[:nat]['linux'][:packages] = %w(
  build-essential
  exuberant-ctags
  hfsplus
  hfsprogs
  hfsutils
  ruby
  ruby-dev
  htop
)

default[:nat]['darwin'][:packages] = %w(
  ctags
  ruby19
)

default[:nat][:the_silver_searcher]['darwin'][:build_dependencies] = %w(
  automake
  pkgconfig
  pcre
)

default[:nat][:the_silver_searcher]['linux'][:build_dependencies] = %w(
  automake
  pkg-config
  libpcre3-dev
  zlib1g-dev
  liblzma-dev
)

default[:nat][:the_silver_searcher][:scm_url] =
  'https://github.com/ggreer/the_silver_searcher.git'

default[:nat][:metal][:packages] = %w(
  ario
  chromium-browser
  claws-mail
  liferea
  pidgin
  rxvt-unicode-256color
  vlc
  weechat-curses
  zim
)

default[:nat][:weechat][:src_url] = "http://www.weechat.org/files/src/weechat-0.4.2.tar.bz2"
default[:nat][:weechat][:build_dependencies] = %w(
  build-essential
  cmake
  libncursesw5-dev
  libcurl4-gnutls-dev
  zlib1g-dev
  libgcrypt11-dev
  libgnutls-dev
  gettext
  ca-certificates
  libaspell-dev
  python-dev
  libperl-dev
  ruby1.9.1-dev
  liblua5.1-0-dev
  tcl-dev
)

default[:nat][:weechat][:plugins] = [
  {"path" => ".weechat/python/growl.py", "url" => "http://weechat.org/files/scripts/growl.py"},
  {"path" => ".weechat/python/jabber.py", "url" => "http://weechat.org/files/scripts/jabber.py"},
  {"path" => ".weechat/python/shell.py", "url" => "http://weechat.org/files/scripts/shell.py"},
  {"path" => ".weechat/python/tinyurl.py", "url" => "http://weechat.org/files/scripts/tinyurl.py"},
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
  {:name => "libxft-dev"},
  {:name => "libxft2"},
  {:name => "libx11-dev"},
  {:name => "libxext-dev"},
  {:name => "libxt-dev"},
  {:name => "libxrandr-dev"},
  {:name => "libxinerama-dev"},
  {:name => "libxrender-dev"}
]

default[:nat][:wmii][:source_url] = "http://dl.suckless.org/wmii/wmii+ixp-3.9b1.tbz"

default[:nat][:gem_packages] = [
  {"name" => "gist"}
]

default[:nat][:vim][:plugins] = [
  {"path"=>".vim/autoload/vim-pathogen", "url"=>"git://github.com/tpope/vim-pathogen.git"},

  {"path"=>".vim/bundle/ctrl-p.vim", "url"=>"git://github.com/kien/ctrlp.vim.git"},
  {"path"=>".vim/bundle/fugitive", "url"=>"git://github.com/tpope/vim-fugitive.git"},
  {"path"=>".vim/bundle/neocomplcache", "url"=>"https://github.com/Shougo/neocomplcache.vim.git"},
  {"path"=>".vim/bundle/nerdtree", "url"=>"git://github.com/scrooloose/nerdtree.git"},
  {"path"=>".vim/bundle/supertab", "url"=>"git://github.com/ervandew/supertab.git"},
  {"path"=>".vim/bundle/syntastic", "url"=>"https://github.com/scrooloose/syntastic.git"},
  {"path"=>".vim/bundle/vim-ack", "url"=>"git://github.com/mileszs/ack.vim.git"},
  {"path"=>".vim/bundle/vim-addon-mw-utils", "url"=>"git://github.com/MarcWeber/vim-addon-mw-utils.git"},
  {"path"=>".vim/bundle/vim-async-command", "url"=>"git://github.com/pydave/AsyncCommand.git"},
  {"path"=>".vim/bundle/vim-clojure-static", "url"=>"git://github.com/guns/vim-clojure-static.git"},
  {"path"=>".vim/bundle/vim-coffee-script", "url"=>"git://github.com/kchmck/vim-coffee-script.git"},
  {"path"=>".vim/bundle/vim-colors-solarized", "url"=>"git://github.com/altercation/vim-colors-solarized.git"},
  {"path"=>".vim/bundle/vim-cucumber", "url"=>"git://github.com/tpope/vim-cucumber.git"},
  {"path"=>".vim/bundle/vim-easygrep", "url"=>"git://github.com/vim-scripts/EasyGrep.git"},
  {"path"=>".vim/bundle/vim-fakeclip", "url"=>"git://github.com/kana/vim-fakeclip.git"},
  {"path"=>".vim/bundle/vim-flake8", "url"=>"https://github.com/nvie/vim-flake8.git"},
  {"path"=>".vim/bundle/vim-foreplay", "url"=>"git://github.com/tpope/vim-foreplay.git"},
  {"path"=>".vim/bundle/vim-git", "url"=>"https://github.com/tpope/vim-git.git"},
  {"path"=>".vim/bundle/vim-gitsessions", "url"=>"https://github.com/wting/gitsessions.vim.git"},
  {"path"=>".vim/bundle/vim-gocode", "url"=>"https://github.com/Blackrush/vim-gocode.git"},
  {"path"=>".vim/bundle/vim-golang", "url"=>"https://github.com/jnwhiteh/vim-golang.git"},
  {"path"=>".vim/bundle/vim-haml", "url"=>"git://github.com/tpope/vim-haml.git"},
  {"path"=>".vim/bundle/vim-html5", "url"=>"git://github.com/othree/html5.vim.git"},
  {"path"=>".vim/bundle/vim-jade", "url"=>"git://github.com/digitaltoad/vim-jade.git"},
  {"path"=>".vim/bundle/vim-latex-live-preview", "url"=>"git://github.com/xuhdev/vim-latex-live-preview.git"},
  {"path"=>".vim/bundle/vim-less", "url"=>"https://github.com/groenewege/vim-less.git"},
  {"path"=>".vim/bundle/vim-literate-coffeescript", "url"=>"https://github.com/mintplant/vim-literate-coffeescript.git"},
  {"path"=>".vim/bundle/vim-markdown", "url"=>"git://github.com/tpope/vim-markdown.git"},
  {"path"=>".vim/bundle/vim-nerdcommenter", "url"=>"git://github.com/scrooloose/nerdcommenter.git"},
  {"path"=>".vim/bundle/vim-powerline-1", "url"=>"git://github.com/Lokaltog/vim-powerline.git"},
  {"path"=>".vim/bundle/vim-protobuf-syntax", "url"=>"git://github.com/jdevera/vim-protobuf-syntax.git"},
  {"path"=>".vim/bundle/vim-ragtag", "url"=>"git://github.com/tpope/vim-ragtag.git"},
  {"path"=>".vim/bundle/vim-rails", "url"=>"git://github.com/tpope/vim-rails.git"},
  {"path"=>".vim/bundle/vim-rainbow-parenthesis", "url"=>"git://github.com/kien/rainbow_parentheses.vim.git"},
  {"path"=>".vim/bundle/vim-rspec", "url"=>"https://github.com/thoughtbot/vim-rspec.git"},
  {"path"=>".vim/bundle/vim-scala", "url"=>"https://github.com/derekwyatt/vim-scala.git"},
  {"path"=>".vim/bundle/vim-snippets", "url"=>"git://github.com/garbas/vim-snipmate.git"},
  {"path"=>".vim/bundle/vim-stylus", "url"=>"https://github.com/wavded/vim-stylus.git"},
  {"path"=>".vim/bundle/vim-surround", "url"=>"git://github.com/tpope/vim-surround.git"},
  {"path"=>".vim/bundle/vim-tabular", "url"=>"git://github.com/godlygeek/tabular.git"},
  {"path"=>".vim/bundle/vim-tagbar", "url"=>"git://github.com/majutsushi/tagbar.git"},
  {"path"=>".vim/bundle/vim-tbone", "url"=>"git://github.com/tpope/vim-tbone.git"},
  {"path"=>".vim/bundle/vim-tlib", "url"=>"git://github.com/tomtom/tlib_vim.git"},
  {"path"=>".vim/bundle/vim-tslime", "url"=>"git://github.com/jgdavey/tslime.vim.git"},

  # colors i.e. http://www.youtube.com/watch?v=KP0OaUOQGCg
  {"path"=>".vim/bundle/vim-vividchalk", "url"=>"git://github.com/tpope/vim-vividchalk.git"},
  {"path"=>".vim/colors/vim-luna", "url"=>"git://github.com/Pychimp/vim-luna.git"}
]
