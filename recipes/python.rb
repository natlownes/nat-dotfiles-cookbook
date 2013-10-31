
execute "install-setuptools" do
  command "wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python"
end

execute "install-pip" do
  command "https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | python"
end

execute "install-pyflakes-globally" do
  command "pip install --upgrade pyflakes"
  only_if "type python > /dev/null && type pip > /dev/null"
end

