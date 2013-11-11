package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'python2.7'
  },
  'mac_os_x' => {
    'default' => 'python27'
  }
})

package package_name

execute "install-setuptools" do
  command "wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python"
  not_if "type easy_install > /dev/null"
end

execute "install-pip" do
  command "wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | python"
  not_if "type pip > /dev/null"
end

execute "install-virtualenv" do
  command "pip install --upgrade virtualenv"
  not_if "type python > /dev/null && type pip > /dev/null"
end

execute "install-pyflakes-globally" do
  command "pip install --upgrade pyflakes"
  only_if "type python > /dev/null && type pip > /dev/null"
end

execute "install-flake8-globally" do
  command "pip install --upgrade flake8"
  only_if "type python > /dev/null && type pip > /dev/null"
end


