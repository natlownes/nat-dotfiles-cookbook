default[:nat][:packages] = %w(
  ssh
  vim-nox
  tmux
  build-essential
  zsh
  exuberant-ctags
  ruby
  ruby-dev
  tig
  bash-completion
)

default[:nat][:metal][:packages] = %w(
  weechat-curses
  vlc
  pidgin
  ario
  claws-mail
  liferea
  zim
  rxvt-unicode-256color
  chromium-browser
  tcplay
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
  {"name" => "jist"},
  {"name" => "rumai", "version" => "~> 3"},
  {"name" => "rumai", "version" => ">= 4.1.3"},
  {"name" => "inochi", "version" => "~> 5.0.2"},
  {"name" => "kwalify", "version" => ">= 0.7.2"},
  {"name" => "barometer", "version" => "~> 0.7.3"},
  {"name" => "librmpd", "version" => "~> 0.1"}
]

default[:nat][:vim][:plugins] = [
  {"path"=>".vim/autoload/vim-pathogen", "url"=>"git://github.com/tpope/vim-pathogen.git"},
  {"path"=>".vim/bundle/ctrl-p.vim", "url"=>"git://github.com/kien/ctrlp.vim.git"},
  {"path"=>".vim/bundle/fugitive", "url"=>"git://github.com/tpope/vim-fugitive.git"},
  {"path"=>".vim/bundle/nerdtree", "url"=>"git://github.com/scrooloose/nerdtree.git"},
  {"path"=>".vim/bundle/supertab", "url"=>"git://github.com/ervandew/supertab.git"},
  {"path"=>".vim/bundle/syntastic", "url"=>"https://github.com/scrooloose/syntastic.git"},
  {"path"=>".vim/bundle/vim-ack", "url"=>"git://github.com/mileszs/ack.vim.git"},
  {"path"=>".vim/bundle/vim-async-command", "url"=>"git://github.com/pydave/AsyncCommand.git"},
  {"path"=>".vim/bundle/vim-coffee-script", "url"=>"git://github.com/kchmck/vim-coffee-script.git"},
  {"path"=>".vim/bundle/vim-colors-solarized", "url"=>"git://github.com/altercation/vim-colors-solarized.git"},
  {"path"=>".vim/bundle/vim-cucumber", "url"=>"git://github.com/tpope/vim-cucumber.git"},
  {"path"=>".vim/bundle/vim-easygrep", "url"=>"git://github.com/vim-scripts/EasyGrep.git"},
  {"path"=>".vim/bundle/vim-fakeclip", "url"=>"git://github.com/kana/vim-fakeclip.git"},
  {"path"=>".vim/bundle/vim-gocode", "url"=>"https://github.com/Blackrush/vim-gocode.git"},
  {"path"=>".vim/bundle/vim-golang", "url"=>"https://github.com/jnwhiteh/vim-golang.git"},
  {"path"=>".vim/bundle/vim-haml", "url"=>"git://github.com/tpope/vim-haml.git"},
  {"path"=>".vim/bundle/vim-html5", "url"=>"git://github.com/othree/html5.vim.git"},
  {"path"=>".vim/bundle/vim-jade", "url"=>"git://github.com/digitaltoad/vim-jade.git"},
  {"path"=>".vim/bundle/vim-latex-live-preview", "url"=>"git://github.com/xuhdev/vim-latex-live-preview.git"},
  {"path"=>".vim/bundle/vim-less", "url"=>"https://github.com/groenewege/vim-less.git"},
  {"path"=>".vim/bundle/vim-literate-coffeescript", "url"=>"https://github.com/mintplant/vim-literate-coffeescript.git"},
  {"path"=>".vim/bundle/vim-markdown", "url"=>"git://github.com/tpope/vim-markdown.git"},
  {"path"=>".vim/bundle/vim-matchit", "url"=>"git://github.com/tsaleh/vim-matchit.git"},
  {"path"=>".vim/bundle/vim-nerdcommenter", "url"=>"git://github.com/scrooloose/nerdcommenter.git"},
  {"path"=>".vim/bundle/vim-powerline-1", "url"=>"git://github.com/Lokaltog/vim-powerline.git"},
  {"path"=>".vim/bundle/vim-ragtag", "url"=>"git://github.com/tpope/vim-ragtag.git"},
  {"path"=>".vim/bundle/vim-rails", "url"=>"git://github.com/tpope/vim-rails.git"},
  {"path"=>".vim/bundle/vim-rspec", "url"=>"https://github.com/thoughtbot/vim-rspec.git"},
  {"path"=>".vim/bundle/vim-surround", "url"=>"git://github.com/tpope/vim-surround.git"},
  {"path"=>".vim/bundle/vim-tabular", "url"=>"git://github.com/godlygeek/tabular.git"},
  {"path"=>".vim/bundle/vim-tagbar", "url"=>"git://github.com/majutsushi/tagbar.git"},
  {"path"=>".vim/bundle/vim-vividchalk", "url"=>"git://github.com/tpope/vim-vividchalk.git"},
  {"path"=>".vim/colors/vim-luna", "url"=>"git://github.com/Pychimp/vim-luna.git"}
]

