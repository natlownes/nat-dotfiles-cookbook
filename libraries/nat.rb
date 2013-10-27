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
end

