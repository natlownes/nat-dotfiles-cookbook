extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


package 'xbindkeys'
package 'xvkbd'

template "#{home_dir}/.xbindkeysrc.scm" do
  owner username
  source "xorg/xbindkeysrc.scm.erb"
end

template "#{home_dir}/.xsessionrc" do
  owner username
  source "xorg/xsessionrc"
  variables({
    :is_chromebook => node.is_chromebook?,
    :input_id => `xinput | grep cyapa | cut -f 2 | sed -e 's/id=//'`.strip()
  })
end
