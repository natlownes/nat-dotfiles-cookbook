extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'wget'

# adapted from:  https://www.dropbox.com/install?os=lnx

if node.os == 'linux'
  arch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"
  installed = File.directory?("#{home_dir}/.dropbox-dist")

  url = "https://www.dropbox.com/download?plat=lnx.#{arch}"

  execute 'install Dropbox' do
    user username
    command "cd #{home_dir} && wget -O - #{url} | tar xzf -"

    action :run
    only_if {
      node[:nat][:dropbox][:force_install] || !installed
    }
  end
end
