# Run with:
# sudo puppet apply /home/vagrant/htdocs/modules/hello_world/manifests/init.pp --debug --modulepath=/home/vagrant/htdocs/modules/

if $::operatingsystem == 'Ubuntu' {
    file { '/etc/motd':
      path    => '/etc/motd',
      content => template('hello_world/etc/motd_ubuntu.erb'),
      backup  => '.puppet-bak'
    }
} else {
    file { '/etc/motd':
      path    => '/etc/motd',
      content => template('hello_world/etc/motd_other.erb'),
      backup  => '.puppet-bak'
    }
}