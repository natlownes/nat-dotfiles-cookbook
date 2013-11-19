extend Nat::UserHelpers
username = user_name()

vim_dir          = "#{home_dir()}/.vim"
vim_bundle_dir   = "#{home_dir()}/.vim/bundle"
vim_colors_dir   = "#{home_dir()}/.vim/colors"
vim_autoload_dir = "#{home_dir()}/.vim/autoload"

vim_powerline_segments     = "#{vim_autoload_dir}/Powerline/Segments"
vim_powerline_colorschemes = "#{vim_autoload_dir}/Powerline/Colorschemes"


package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'vim-nox'
  },
  'mac_os_x' => {
    'default' => 'vim'
  }
})

package package_name

vim_directories = [
  vim_bundle_dir,
  vim_colors_dir,
  vim_autoload_dir,
  vim_powerline_segments,
  vim_powerline_colorschemes,
  "#{vim_dir}/vimrcs"
]

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

remote_directory "#{vim_dir}/colors" do
  source "vim/colors"
  owner username
end

(node[:nat][:vim][:plugins] || []).each do |plugin|
  repo_url = plugin['url']
  path     = "#{home_dir()}/#{plugin['path']}"
  branch   = plugin['branch'] || 'master'

  # TODO: blow away directory if
  # not git repo or if remote doesn't match
  #directory path do
    #action :delete

    #only_if {
      #`pushd #{path} && git remote -v && popd`
    #}
  #end

  git path do
    repository repo_url
    user username

    action :sync
  end
end

link "#{vim_dir}/autoload/pathogen.vim" do
  to "#{vim_dir}/autoload/vim-pathogen/autoload/pathogen.vim"
  owner username
end

execute "ensure-ownership" do
  command "chown -R #{username} #{vim_dir}"
end


