sudo::conf { 'SysAdmin':
  priority => 10,
  content  => "%SysAdmin ALL=(ALL) ALL",
}
#Replace SysAdmin with any group you want (including LDAP Groups)
