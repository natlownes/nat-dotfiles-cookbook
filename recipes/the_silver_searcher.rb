#
# nat::the_silver_searcher
#

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

build_deps = node[:nat][:the_silver_searcher][node.os][:build_dependencies] ||
  []

source_destination = "#{home_dir}/src/the-silver-searcher"
scm_url            = node[:nat][:the_silver_searcher][:scm_url]

build_deps.each do |pkg|
  package pkg
end

directory "#{home_dir}/src" do
  recursive true
  owner username
end

execute "clone-the-silver-searcher" do
  user username
  cwd "#{home_dir}/src"

  command "git clone #{scm_url} #{source_destination}"
  not_if { File.directory?(source_destination) }
end

execute "pull-the-silver-searcher" do
  user username
  cwd  source_destination

  command "git remote update origin && git pull origin master"
end

execute "build-the-silver-searcher" do
  cwd source_destination
  user username

  command "bash build.sh"

  notifies :run, "execute[install-the-silver-searcher]", :immediately
  not_if "which ag"
end

execute "install-the-silver-searcher" do
  cwd source_destination

  action :nothing
  command "make install"
end
