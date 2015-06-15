# build truecrypt from source
#

package 'encfs'

if node.os == 'linux'
  package 'hfsplus'
  package 'hfsutils'
  package 'hfsprogs'
end
