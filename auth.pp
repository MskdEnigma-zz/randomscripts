#This package allows connection to OpenLDAP Server
  package { 'openldap-clients':
    ensure => installed,
  }

#Should already be installed but allows for Authentication on CentOS/RHEL 

  package { 'sssd':
    ensure => installed,
  }
 
#Creates a Directory for a CA/CA-Chain Cerfiticate
 
  file { '/etc/openldap/cacerts/':
    ensure => directory
  }

#Next 6 pull the certs and the Mozilla NSS CertDB from the Puppet Server and places them in the right location  

  file { '/etc/openldap/certs/wildcard.cert.pem':
    ensure => file,
    source => 'puppet:///files/ldap/wildcard.cert.pem',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/certs/wildcard.key.pem':
    ensure => file,
    source => 'puppet:///files/ldap/wildcard.key.pem',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/cacerts/ca-chain.cert.pem':
    ensure => file,
    source => 'puppet:///files/ldap/ca-chain.cert.pem',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/cacerts/cert8.db':
    ensure => file,
    source => 'puppet:///files/ldap/cert8.db',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/cacerts/key3.db':
    ensure => file,
    source => 'puppet:///files/ldap/key3.db',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/cacerts/secmod.db':
    ensure => file,
    source => 'puppet:///files/ldap/secmod.db',
    require => Package['openldap-clients'],
  }

#This pulls the OpenLDAP Client Config from the Puppet Server  
  
  file { '/etc/openldap/ldap.conf':
    ensure => file,
    source => 'puppet:///files/ldap/ldap.conf',
    require => Package['openldap-clients'],
  }

#This pulls the SSSD Config from the Puppet Server
  
  file { '/etc/sssd/sssd.conf':
    ensure => file,
    source => 'puppet:///files/ldap/sssd.conf',
    mode => '600',
    require => Package['sssd'],
  }

#This sets the Authentication to TLS enabled OpenLDAP
  
  exec { '/usr/sbin/authconfig --enablesssd --enablesssdauth --enableldap --enableldapauth --enablemkhomedir --ldapserver=ldaps://ldap01.mtaganet.gg,ldaps://ldap02.mtaganet.gg --ldapbasedn=dc=mtaganet,dc=gg --enablelocauthorize --enableldaptls --enablecachecreds --enablerfc2307bis  --update':
    require => [ File['/etc/openldap/ldap.conf'], File['/etc/sssd/sssd.conf'], ],
  }

#Some things to read include:
#https://onemoretech.wordpress.com/2014/02/23/sssd-for-ldap-auth-on-linux/
#https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sssd-ldap-sudo.html
