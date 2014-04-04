class profile::docker-setup {
  notify { 'profile::docker-setup': }

  include 'docker'

  # Add docker images
  Class['docker'] -> docker::image { 'base': }
  Class['docker'] -> docker::image { 'ubuntu': }

  # Add vagrant to the docker group so that we don't have to use sudo all the time
  Class['docker'] -> exec {"vagrant docker membership":
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    unless  => "grep -q 'docker\\S*vagrant' /etc/group",
    command => "usermod -aG docker vagrant",
    require => User['vagrant'],
    notify  => Service['docker'],
  }

}
