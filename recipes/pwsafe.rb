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
  execute 'install-pwsafe' do
    command 'port install pwsafe'
  end
end

if node.os == 'linux'
  # install from source
  #execute 'install-pwsafe-build-deps' do
    #command
  #end
end



