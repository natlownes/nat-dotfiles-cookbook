extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

cookbook_file "#{home_dir}/.xface" do
  source "various/xface"
  owner  username
end
