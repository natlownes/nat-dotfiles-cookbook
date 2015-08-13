extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


packer_directory = "#{home_dir}/opt/local/packer"

directory packer_directory do
  owner     username
  recursive true
end

remote_file "#{home_dir}/opt/local/packer/packer.zip" do
  source node[:nat][:packer][:url]
  owner username
  not_if {
    ::File.exists?("#{home_dir}/opt/local/packer/packer.zip")
  }

  notifies :run, 'bash[extract-packer]', :immediately
end

bash 'extract-packer' do
  cwd packer_directory

  action :nothing
end

link "#{home_dir}/.bin/packer" do
  to    "#{packer_directory}/packer"
  owner username
end
