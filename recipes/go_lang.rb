extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directories = [
  "#{home_dir}/src/go",
  "#{home_dir}/src/golang",
]

directories.each do |dir|
  directory dir do
    owner     username
    recursive true
  end
end

package 'mercurial' do
  action :install
end

if node[:nat][:golang][:force_install]
  directory "#{home_dir}/src/go"
  action    :delete
  recursive true
end

if node.os == 'linux'
  build_dependencies = %w(gcc libc6-dev)

  build_dependencies.each do |dep|
    package dep do
      action :install
    end
  end
end

execute "hg clone -u release #{node[:nat][:golang][:scm_url]}" do
  cwd     "#{home_dir}/src/golang"
  user    username

  only_if { !::File.directory?("#{home_dir}/src/golang") }
  notifies :run, "bash[build-and-install-go]", :immediately
end

bash 'build-and-install-go' do
  cwd     "#{home_dir}/src/golang/go/src"
  command './all.bash'
  user    username

  action :nothing
end
