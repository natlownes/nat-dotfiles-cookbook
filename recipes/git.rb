extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

template "#{home_dir}/.gitconfig" do
  source "git/gitconfig"
  owner username
end

template "#{home_dir}/.gitignore" do
  source "git/gitignore"
  owner username
end

template "#{home_dir}/.gitignore_global" do
  source "git/gitignore_global"
  owner username
end

execute "install-gitflow" do
  command "wget --no-check-certificate -q -O - https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh | bash"
end


