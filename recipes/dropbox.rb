extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'wget'

# adapted from:  https://www.dropbox.com/install?os=lnx

if node.os == 'linux'
  arch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"

  url                  = "https://www.dropbox.com/download?plat=lnx.#{arch}"
  installed            = File.directory?("#{home_dir}/.dropbox-dist")
  force_install        = node[:nat][:dropbox][:force_install]
  destination_dir_name = '.dropbox-dist'

  directory ::File.join(home_dir, destination_dir_name) do
    recursive true
    action    :delete

    only_if { installed && force_install }
  end

  execute 'install Dropbox' do
    user username
    command "cd #{home_dir} && wget -O - #{url} | tar xzf -"
    action :run

    only_if {
      force_install || !installed
    }
  end
end
