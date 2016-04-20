class { '::ntp':
    servers => [ '' ],
}
#set the fqdn or IP for the time server you want, I used this because ntp traffic was blocked and only was allowed to the DC
