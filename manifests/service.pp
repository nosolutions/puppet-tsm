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
# Copyright 2014-2015 Toni Schmidbauer
#
class tsm::service {

  if ! ($::tsm::service_ensure in [ true, false, 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $::tsm::service_manage == true {
    case $::osfamily {
      redhat: {
        contain tsm::service::redhat
      }
      debian: {
        contain tsm::service::debian
      }
      suse: {
        contain tsm::service::sles
      }
      solaris: {
        contain tsm::service::solaris
      }
      'AIX': {
        contain tsm::service::aix
      }
      default: {
        fail("Unsupported osfamily ${::osfamily} for managing the service!")
      }
    }

    if $::tsm::set_initial_password == true {
      $password = tsm_generate_rand_string()

      exec {'generate-tsm.pwd':
        command => "dsmc set password ${::tsm::initial_password} ${password}",
        creates => $::tsm::tsm_pwd,
        path    => ['/bin', '/usr/bin']
      }
      Exec['generate-tsm.pwd'] -> Service[$::tsm::service_name]
    }
  }
}
