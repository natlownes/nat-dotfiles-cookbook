execute "apt-get-update" do
  command "apt-get update --fix-missing"

  action :nothing
end

if node.platform == 'ubuntu'
  file "/etc/apt/sources.list.d/spotify.list" do
    content "deb http://repository.spotify.com stable non-free"

    notifies :run, "execute[apt-get-update]", :immediately
  end

  execute "install-spotify-key" do
    command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59"

    notifies :run, "execute[apt-get-update]", :immediately
  end

  package 'spotify-client'

end

