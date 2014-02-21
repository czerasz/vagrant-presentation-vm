class role::webserver inherits role {
  notify { 'role::webserver': }

  include profile::web
}