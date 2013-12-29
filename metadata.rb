name             'nat'
maintainer       'Nat Lownes'
maintainer_email 'nat@looting.biz'
license          'Apache 2.0'
description      'Installs/Configures nat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(
  apt
).each { |p| depends p }
