bootstrap:
	sudo chef-client || sudo chef-client -v | grep -q '11' || curl -L https://www.opscode.com/chef/install.sh | sudo bash

osx: bootstrap
	sudo chef-client -z -j .chef/nodes/osx_workstation.json -c .chef/solo-bootstrap.rb

linux: bootstrap
	sudo chef-client -z -j .chef/nodes/linux_workstation.json -c .chef/solo-bootstrap.rb

.PHONY: osx linux bootstrap

