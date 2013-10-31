
execute "install-setuptools" do
  command "wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python"
  not_if "type easy_install > /dev/null"
end

execute "install-pip" do
  command "wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | python"
  not_if "type pip > /dev/null"
end

execute "install-pyflakes-globally" do
  command "pip install --upgrade pyflakes"
  only_if "type python > /dev/null && type pip > /dev/null"
end

