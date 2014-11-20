extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

include_recipe 'nat::git'

package 'zsh' do
  action :upgrade
end

directory "#{home_dir}/.zsh" do
  recursive true
  owner username
  action :create
end

directory "#{home_dir}/.zsh/cache" do
  recursive true
  owner username
  action :create
end

directory "#{home_dir}/.zsh/functions/Completion" do
  recursive true
  owner username
  action :create
end

template "#{home_dir}/.zshrc" do
  owner username
  source "zsh/rc"
end

template "#{home_dir}/.zsh/vi_mode_indicator.zsh" do
  owner username
  source "zsh/vi_mode_indicator.zsh"
end

template "#{home_dir}/.zsh/git-completion.zsh" do
  owner username
  source "zsh/git-completion.zsh"
end

template "#{home_dir}/.zsh/prompt.zsh" do
  owner username
  source "zsh/prompt.zsh"
end

template "#{home_dir}/.zshenv" do
  owner username
  source "zsh/zshenv.erb"
  variables({
    :home => home_dir
  })
end

git "#{home_dir}/.zsh/functions/Completion/git-flow" do
  repository "https://github.com/bobthecow/git-flow-completion.git"

  action :sync
end
