node 'webserver.local.vm' {
  include role::webserver
}

node 'dbserver.local.vm' {
  include role::dbserver
}