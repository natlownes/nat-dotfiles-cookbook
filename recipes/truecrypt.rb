# build truecrypt from source
#

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


source_url = "https://dl.dropboxusercontent.com/u/31982598/TrueCrypt%207.1a%20Source.tar.gz"

build_deps = %w(
  build-essential
  nasm
  libp11-dev
  libgtk2.0-dev
  libwxgtk2.8-dev
  libwxbase2.8-dev
  libcrypto++-dev
  libpkcs11-helper1-dev
  libfuse-dev
  libfuse2
  libgnutls-dev
  libgck-1-dev
  libopencryptoki-dev
)

build_deps.each do |package_name|
  package package_name
end

directory "#{home_dir}/src" do
  recursive true
  owner username
end

directory "#{home_dir}/src/pkcs11" do
  recursive true
  owner username
end

pkcs_files = %w(
pkcs11.h
pkcs11f.h
pkcs11t.h
)

pkcs_files.each do |filename|
  remote_file "#{home_dir}/src/pkcs11/#{filename}" do
    source "ftp://ftp.rsasecurity.com/pub/pkcs/pkcs-11/v211/#{filename}"
    owner username
    action :create_if_missing
  end
end

execute "extract-tc" do
  user username
  cwd "#{home_dir}/src"
  command  "tar -xzf truecrypt-source.tar.gz"

  notifies :create, "cookbook_file[#{home_dir}/src/truecrypt-7.1a-source/Common/SecurityToken.cpp]", :immediately
  action :nothing
end

cookbook_file "#{home_dir}/src/truecrypt-7.1a-source/Common/SecurityToken.cpp" do
  source "truecrypt/SecurityToken.cpp"
  action :nothing
  notifies :run, "execute[build-tc]", :immediately
end

execute "build-tc" do
  cwd "#{home_dir}/src/truecrypt-7.1a-source"
  environment({
    'NOGUI' => '1',
    'PKCS11_INC' => "#{home_dir}/src/pkcs11"
  })
  user username
  command "make clean && make"

  action :nothing
  notifies :run, "execute[install-tc]", :immediately
end

execute "install-tc" do
  cwd "#{home_dir}/src/truecrypt-7.1a-source"

  user username
  command "make install"

  action :nothing
end

remote_file "#{home_dir}/src/truecrypt-source.tar.gz" do
  source source_url
  owner username

  action :create_if_missing
  notifies :run, "execute[extract-tc]", :immediately
end



