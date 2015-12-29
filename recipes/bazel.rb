extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


bazel_exec_path     = ::File.join(home_dir, 'bin', 'bazel')
zsh_completion_path = ::File.join(home_dir, '.zsh', 'completion')

directory zsh_completion_path do
  recursive true
  owner     username
end

apt_repository 'bazel' do
  uri 'ppa:webupd8team/java'
  key 'EEA14886'
  keyserver 'keyserver.ubuntu.com'
  distribution node['lsb']['codename']

  action :add
end

packages = %w(
oracle-java8-installer
pkg-config
zip
g++
zlib1g-dev
unzip
)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{::File.join(zsh_completion_path, '_bazel')}" do
  source node[:nat][:bazel][:zsh_completion_url]
  owner username
end

remote_file '/tmp/bazel-installer.sh' do
  source node[:nat][:bazel][:install_url]
  owner username
  checksum '617d34dc76a63f40ba04ad9b394a163302103ea3466c2f13d19500f45b765a38'
  notifies :run, 'bash[install-bazel]', :immediately
  not_if { ::File.exists?(bazel_exec_path) }
end

bash 'install-bazel' do
  user username
  code %{
    chmod +x /tmp/bazel-installer.sh'
    ./tmp/bazel-installer.sh --user
  }
  creates bazel_exec_path
end
