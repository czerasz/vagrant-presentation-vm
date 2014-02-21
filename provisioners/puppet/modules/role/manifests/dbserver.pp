class role::dbserver inherits role {
  notify { 'role::dbserver': }

  include profile::nosql_db
}