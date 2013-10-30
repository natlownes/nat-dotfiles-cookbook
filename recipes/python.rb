
execute "install-pyflakes-globally" do
  command "pip install --upgrade pyflakes"
  only_if "type python > /dev/null"
end

