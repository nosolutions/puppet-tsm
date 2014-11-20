# == Class: tsm::service::debian
#
# Manage tsm service on debian
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
# David Orn Johannsson <davideaglephotos@gmail.com>
#
# === Copyright
#
# Copyright 2014 Toni Schmidbauer
#
class tsm::service::debian {

  file { $::tsm::service_script:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => $::tsm::service_script_source,
  }

  service { $::tsm::service_name:
    ensure     => $::tsm::service_ensure,
    enable     => $::tsm::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

  File[$::tsm::service_script] -> Service[$::tsm::service_name]
}
