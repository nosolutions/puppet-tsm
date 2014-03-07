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
    file { $::tsm::service_script:
      ensure  => file,
      path    => $::tsm::service_script,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => $::tsm::service_file,
    }

    service { $::tsm::service_name:
      ensure     => $::tsm::service_ensure,
      enable     => $::tsm::service_enable,
      name       => $::tsm::service_name,
      hasstatus  => true,
      hasrestart => true,
    }

    File[$::tsm::service_script] -> Service[$::tsm::service_name]
  }
}
