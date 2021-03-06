extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


package 'kpcli'

if node.is_desktop?
  package 'keepass2'
  package 'keepassx'
  package 'mono-complete'

  plugin_dir = '/usr/lib/keepass2/plugins'

  directory plugin_dir do
    recursive true
    mode '777'

    action :create
  end

  remote_file "#{plugin_dir}/KeePassHttp.dll" do
    source 'https://github.com/pfn/keepasshttp/raw/master/mono/KeePassHttp.dll'
    mode   '777'
  end

  remote_file "#{plugin_dir}/Newtonsoft.Json.dll" do
    source 'https://github.com/pfn/keepasshttp/raw/master/mono/Newtonsoft.Json.dll'
    mode   '777'
  end
end
