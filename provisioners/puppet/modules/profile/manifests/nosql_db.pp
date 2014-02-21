class profile::nosql_db {
  notify { 'profile::nosql_db': }

  class {'::mongodb::globals':
    manage_package_repo => true,
    bind_ip             => $::ipaddress_eth1,
  }
  -> class {'::mongodb::server':
    port    => 27018,
    verbose => true,
  }
}