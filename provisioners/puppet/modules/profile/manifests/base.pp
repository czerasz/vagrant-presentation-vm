class profile::base {
  notify { 'profile::base': }

  Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

  # @begin: setup timezone
  class { 'timezone':
    timezone => 'Europe/Berlin',
  }
  # @end: setup timezone

  # @begin: setup git
  include git

  git::config { 'user.name':
    value   => 'Michael Czeraszkiewicz',
    require => Class['git'],
  }

  git::config { 'user.email':
    value   => 'czerasz.hosting@gmail.com',
    require => Class['git'],
  }
  # @end: setup git

  # @begin: setup vim
  class { 'vim':
    before => File['/home/vagrant/.vimrc']
  }
  file { '/home/vagrant/.vimrc':
    source => "puppet:///modules/profile/.vimrc"
  }
  # @end: setup vim

  # @begin: install ohmyzsh
  if(!defined(Package['curl'])) {
    package { 'curl':
      ensure => present,
    }
  }

  if(!defined(Package['zsh'])) {
    package { 'zsh':
      ensure => present,
    }
  }

  # Install oh-my-zsh via bash
  # Code taken from: https://github.com/acme/puppet-acme-oh-my-zsh
  exec { 'ohmyzsh git clone':
    creates => "/home/vagrant/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh",
    user    => 'vagrant',
    require => [Package['git'], Package['zsh']],
  }

  # Create a new zsh config by copying the zsh template from oh-my-zsh
  exec { 'ohmyzsh set default .zshrc':
    creates => "/home/vagrant/.zshrc",
    command => "/bin/cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc",
    user    => 'vagrant',
    require => Exec['ohmyzsh git clone'],
  }

  if ( $::operatingsystem == 'Ubuntu' ) {
    user { 'vagrant':
      ensure  => present,
      name    => 'vagrant',
      shell   => '/usr/bin/zsh',
      require => Package['zsh'],
    }
  } else {
    user { 'vagrant':
      ensure  => present,
      name    => 'vagrant',
      shell   => '/bin/zsh',
      require => Package['zsh'],
    }
  }
  # @end: install ohmyzsh

}