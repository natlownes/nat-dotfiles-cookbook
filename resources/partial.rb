# mimic the "template" api as closely as possible
#
# nat_partial "/etc/modules" do
#   source "modules_partial.erb"
# end

actions        :commit
default_action :commit

attribute :target_file,    :name_attribute => true
attribute :source,         :kind_of => String, :required => true
attribute :delimiter,      :kind_of => [String, NilClass], :default => nil
attribute :comment_prefix, :kind_of => String, :default => '#'
