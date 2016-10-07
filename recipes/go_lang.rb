extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

install_dir = "#{home_dir}/#{node[:nat][:golang][:install_path]}"

directories = [
  "#{home_dir}/src/go",
  install_dir
]

if node[:nat][:golang][:force_install]
  directory install_dir do
    action    :delete
    recursive true
  end
end

directories.each do |dir|
  directory dir do
    owner     username
    recursive true
  end
end

package 'mercurial' do
  action :install
end

if node.os == 'linux'
  build_dependencies = %w(gcc libc6-dev)

  build_dependencies.each do |dep|
    package dep do
      action :install
    end
  end
end

execute 'build-and-install-go' do
  cwd     "#{install_dir}/go/src"
  command './make.bash'
  user    username

  action :nothing
end

#execute "hg clone -u release #{node[:nat][:golang][:scm_url]}" do
  #cwd     install_dir
  #user    username

  #only_if { !::File.directory?("#{install_dir}/go") }
  #notifies :run, "execute[build-and-install-go]", :immediately
#end

execute "git clone #{node[:nat][:golang][:scm_url]}" do
  cwd     install_dir
  user    username

  only_if { !::File.directory?("#{install_dir}/go") }
  notifies :run, "execute[build-and-install-go]", :immediately
end
