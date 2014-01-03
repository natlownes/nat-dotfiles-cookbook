extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


user username do
  action :create
end
