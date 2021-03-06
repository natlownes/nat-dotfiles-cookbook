extend Nat::UserHelpers
username = user_name()

# since we need git to pull down these plugins
include_recipe 'nat::git'

vim_dir             = "#{home_dir()}/.vim"
vim_bundle_dir      = "#{vim_dir}/bundle"
vim_colors_dir      = "#{vim_dir}/colors"
vim_autoload_dir    = "#{vim_dir}/autoload"
vim_after_hooks_dir = "#{vim_dir}/after/plugin"
vim_ftplugin_dir    = "#{vim_dir}/ftplugin"

vim_powerline_segments     = "#{vim_autoload_dir}/Powerline/Segments"
vim_powerline_colorschemes = "#{vim_autoload_dir}/Powerline/Colorschemes"


# TODO:  build vim8 from source
#package_name = value_for_platform({
  #['debian', 'ubuntu'] => {
    #'default' => 'vim-nox'
  #},
  #'mac_os_x' => {
    #'default' => 'vim'
  #}
#})

#package package_name

vim_directories = [
  vim_bundle_dir,
  vim_colors_dir,
  vim_autoload_dir,
  vim_powerline_segments,
  vim_powerline_colorschemes,
  vim_after_hooks_dir,
  vim_ftplugin_dir,
  "#{vim_dir}/vimrcs",
  "#{vim_dir}/after/ftplugin",
]

plugin_hooks = %w(
  TabularMaps.vim
  tabstop.vim
)

vim_directories.each do |dirname|
  directory dirname do
    recursive true
    owner username

    action :create
  end
end

template "#{home_dir()}/.vimrc" do
  source "vim/vimrc"
  owner username
end

template "#{vim_powerline_colorschemes}/trex.vim" do
  source "vim/autoload/Powerline/Colorschemes/trex.vim"
  owner username
end

template "#{vim_powerline_segments}/trex.vim" do
  source "vim/autoload/Powerline/Segments/trex.vim"
  owner username
end

template "#{vim_dir}/grepprg" do
  source "vim/grepprg"
  owner username
end

template "#{vim_dir}/pathogen_init" do
  source "vim/pathogen_init"
  owner username
end

template "#{vim_dir}/vimrcs/coffee_tagbar" do
  source "vim/vimrcs/coffee_tagbar"
  owner username
end

template "#{vim_dir}/vimrcs/go_tagbar" do
  source "vim/vimrcs/go_tagbar"
  owner username
end

template "#{vim_ftplugin_dir}/python.vim" do
  source "vim/ftplugin/python.vim.erb"
  owner username
end

link "#{vim_dir}/after/ftplugin/python.vim" do
 to "#{vim_ftplugin_dir}/python.vim"
 owner username
end

remote_directory "#{vim_dir}/colors" do
  source "vim/colors"
  owner username
end

(plugin_hooks || []).each do |hook_name|
  template "#{vim_after_hooks_dir}/#{hook_name}" do
    owner username
    source "vim/after/plugin/#{hook_name}"
  end
end

(node[:nat][:vim][:plugins_to_remove] || []).each do |plugin|
  plugin_path = "#{home_dir()}/#{plugin['path']}"

  directory plugin_path do
    recursive true
    action :delete
    only_if { File.directory?(plugin_path) }
  end
end

(node[:nat][:vim][:plugins] || []).each do |plugin|
  repo_url    = plugin['url']
  plugin_path = "#{home_dir()}/#{plugin['path']}"
  branch_name = plugin['branch'] || 'master'

  # TODO: blow away directory if
  # not git repo or if remote doesn't match
  #directory plugin_path do
    #action :delete

    #only_if {
      #`pushd #{plugin_path} && git remote -v && popd`
    #}
  #end

  git plugin_path do
    repository repo_url
    user       username
    branch     branch_name

    action :sync
  end
end

execute 'build vimproc' do
  cwd     "#{vim_bundle_dir}/vimproc.vim"
  command 'make'
  user    username
end

link "#{vim_dir}/autoload/pathogen.vim" do
  to "#{vim_dir}/autoload/vim-pathogen/autoload/pathogen.vim"
  owner username
end

execute "ensure-ownership" do
  command "chown -R #{username} #{vim_dir}"
end

offending_nonsense = %w(
/usr/share/vim/vim74/indent/python.vim
)

offending_nonsense.each do |path|
  execute "stop #{path} from goddamned fucking around with my shit" do
    command "rm #{path}"
    only_if { ::File.exist?(path) }
  end
end
