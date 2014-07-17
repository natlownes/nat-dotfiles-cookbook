extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directory "#{home_dir}/src" do
  recursive true
  owner username
end
