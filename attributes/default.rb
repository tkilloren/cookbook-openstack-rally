#
#  Mirrors don't work through bluecoat proxy
#
node.default['yum']['epel']['mirrorlist'] = nil
node.default['yum']['epel']['baseurl'] = 'http://download.fedoraproject.org/pub/epel/7/$basearch'
