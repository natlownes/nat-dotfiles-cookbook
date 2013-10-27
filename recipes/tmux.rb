extend Nat::UserHelpers
username = user_name()
tmux_dir = "#{home_dir()}/.tmux"


package 'tmux'

directory tmux_dir do
  recursive true
  owner username
end

template "#{home_dir()}/.tmux.conf" do
  source "tmux/tmux.conf"
  owner username
end

template "#{tmux_dir}/tmux_clipboard.sh" do
  source "tmux/tmux_clipboard.sh"
  owner username
end

template "#{tmux_dir}/tmux_default_command.sh" do
  source "tmux/tmux_default_command.sh"
  owner username
  mode "0744"
end
