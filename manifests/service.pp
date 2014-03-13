# == Class: tsm::service
#
# Manage the dsmsched process
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { tsm::service
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014 Toni Schmidbauer
#
class tsm::service inherits tsm {

  if ! ($::tsm::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $::tsm::service_manage == true {
    case $::osfamily {
      redhat: {
        include tsm::service::redhat
      }
      solaris: {
        include tsm::service::solaris
      }
    }
  }
}
