extend Nat::UserHelpers
username = user_name()
home     = home_dir()

# a global tsconfig file.  I *think* tsserver will search parent directories
# until one is found
template "#{home}/tsconfig.json" do
  source 'typescript/tsconfig.json'
  owner  username
end
