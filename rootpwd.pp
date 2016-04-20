class site {
  user{ "root":
      ensure => present,
      password => ''
      }
}
# write a password string inside the ''
