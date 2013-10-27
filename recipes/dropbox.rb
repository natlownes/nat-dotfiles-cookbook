extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'wget'

# https://www.dropbox.com/install?os=lnx

if node.os == 'linux'
  arch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"

  url = "https://www.dropbox.com/download?plat=lnx.#{arch}"

  execute 'install Dropbox' do
    user username
    command "cd #{home_dir} && wget -O - #{url} | tar xzf -"

    action :run
    only_if {
      !File.directory?("#{home_dir}/.dropbox-dist")
    }
  end
end




