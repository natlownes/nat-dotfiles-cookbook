module Nat
  module UserHelpers
    def home_dir(username='nat')
      dirs = {
        'darwin' => "/Users/#{username}",
        'linux' =>  "/home/#{username}"
      }
      dirs[node.os] || dirs['linux']
    end

    def user_name ; 'nat' ; end
  end

  module MachineHelpers
    def is_desktop?
      required_memory = 8000000
      required_cores  = 8
      memory          = Integer(node.memory.total[0..-3])
      cores           = node.cpu.count

      cores >= required_cores && memory >= required_memory
    end

    def is_chromebook?
      system "lsmod | grep chromeos"
    end
  end
end

