class profile::web {
  notify { 'profile::web': }

  class { 'nginx': }

  nginx::resource::vhost { $::fqdn :
    www_root => '/home/vagrant/htdocs',
  }
}