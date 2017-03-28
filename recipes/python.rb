package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'python2.7'
  },
  'mac_os_x' => {
    'default' => 'python'
  }
})

dev_package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'python-dev'
  },
  'mac_os_x' => {
    'default' => 'python-dev'
  }
})


exec_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'python2.7'
  },
  'mac_os_x' => {
    'default' => 'python'
  }
})

package package_name do
  action :install
end

package dev_package_name do
  action :install
end

execute "install-setuptools" do
  command "wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | #{exec_name}"
  not_if "type easy_install > /dev/null"
end

execute "install-pip" do
  command "wget https://bootstrap.pypa.io/get-pip.py -O - | #{exec_name}"
  not_if "type pip > /dev/null"
end

execute "install-virtualenv" do
  command "pip install --upgrade virtualenv"
  only_if "type #{package_name} > /dev/null && type pip > /dev/null"
end

execute "install-pyflakes-globally" do
  command "pip install --upgrade pyflakes"
  only_if "type #{package_name} > /dev/null && type pip > /dev/null"
end

execute "install-flake8-globally" do
  command "pip install --upgrade flake8"
  only_if "type #{package_name} > /dev/null && type pip > /dev/null"
end

execute "install-ipdb-globally" do
  command "pip install --upgrade ipdb"
  only_if "type #{package_name} > /dev/null && type pip > /dev/null"
end
