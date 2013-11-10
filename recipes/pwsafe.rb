extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

pwsafe_file = "#{user_dir}/Dropbox/.pwsafe.dat"

link "#{user_dir}/.pwsafe.dat" do
  to pwsafe_file
  owner username
  only_if {
    File.file?(pwsafe_file)
  }
end

if node.os == 'darwin'
  package 'pwsafe'
end

if node.os == 'linux'
  # install from source
  build_dependencies = %w(
    build-essential
    libuuid1
    libwxgtk2.8-dev
    libwxgtk2.8-dbg
    libxerces-c-dev
    libxt-dev
    libxtst-dev
    libykpers-1-dev
    libyubikey-dev
    git
    uuid-dev
    zip
  )

  build_dependencies.each do |pkg|
    package pkg
  end

  execute 'build-pwsafe' do
    #command
  end

  execute 'install-pwsafe' do
  end

  remote_file "#{user_dir}/src/pwsafe-src.tgz" do
    source "http://downloads.sourceforge.net/project/passwordsafe/Linux-BETA/0.92/pwsafe-0.92BETA-src.tgz"
    owner username
  end
end



