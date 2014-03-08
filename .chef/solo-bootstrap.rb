# for use with the solo-bootstrap stuff
this_file_path = File.expand_path(File.dirname(__FILE__))
file_cache_path "/tmp/chef-solo"
data_bag_path   "#{this_file_path}/data_bags"
cookbook_path   [ "#{this_file_path}/../../"]
role_path       "#{this_file_path}/roles"
solo true
