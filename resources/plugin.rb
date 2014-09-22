actions :install, :uninstall
default_action :install

attribute :name, :kind_of => String, :required => true
attribute :version, :kind_of => String, :required => false
