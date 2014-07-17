actions         :install
default_action  :install

attribute :name, :name_attribute => true

attribute :version,         :kind_of => String, :default => '0.0.0'
attribute :source,          :kind_of => String
attribute :configure_flags, :kind_of => String
attribute :make_creates,    :kind_of => String
attribute :installs,        :kind_of => String
