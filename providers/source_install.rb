action :install do
  package 'build-essential'

  name        = new_resource.name
  version     = new_resource.version
  tarball     = "#{name}-#{version}.tar.gz"
  build_root  = "#{node[:srcinstall][:builddir]}/#{name}-#{version}"
  src_root    = "#{build_root}/#{name}-#{version}"

  directory build_root do
    action    :create
    recursive true
    not_if  { installed }
  end

  remote_file "#{build_root}/#{tarball}" do
    source  "#{new_resource.source}/#{tarball}"
    not_if  {
      ::File.exists?("#{build_root}/#{tarball}") or installed
    }
  end

  # TODO: Hope the tarball follows the conventions!
  bash 'extract' do
    cwd     build_root
    code    "tar xzf #{build_root}/#{tarball}"
    not_if  { ::File.exists?(src_root) or installed }
  end

  bash 'configure' do
    cwd     src_root
    code    "./configure #{new_resource.configure_flags}"
    not_if  { ::File.exists?("#{src_root}/config.status") or installed }
  end

  bash 'make' do
    cwd     src_root
    code    'make'
    not_if  {
      new_resource.make_creates != '' and ::File.exists?("#{src_root}/#{new_resource.make_creates}") or\
      installed
    }
  end

  bash 'install' do
    cwd     src_root
    code    'echo && sudo make install'
    not_if  { installed }
  end
end

def installed
  new_resource.installs != '' and ::File.exists?(new_resource.installs)
end
