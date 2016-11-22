module Nat
  module UserHelpers
    def user_name
      node[:nat][:username] || 'nat'
    end

    def home_dir
      username = user_name()
      dirs = {
        'darwin' => "/Users/#{username}",
        'linux' =>  "/home/#{username}"
      }
      dirs[node.os] || dirs['linux']
    end
  end
end


class ::Chef::Node
  def is_desktop?
    required_memory = 8000000
    required_cores  = 8
    memory          = Integer(node['memory']['total'][0..-3])
    cores           = node['cpu']['count']

    cores >= required_cores && memory >= required_memory
  end

  def is_chromebook?
    system "lsmod | grep chromeos"
  end

  def xrandr_outputs
    x11_user = self[:nat][:username] || 'nat'

    xrandr_output = `su #{x11_user} -c "xrandr -q"`.split()
    displays      = []

    xrandr_output.each_with_index do |word, i|
      if word == 'connected'
        displays << xrandr_output[i - 1]
      end
    end
    displays
  end
end
