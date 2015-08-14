# == Class: tsm::service::solaris
#
# Manage the tsm service on solaris
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014-2015 Toni Schmidbauer
#
class tsm::service::solaris inherits tsm {

  file { $::tsm::service_script:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    replace => true,
    source  => $::tsm::service_script_source,
  }

  file { $::tsm::service_manifest:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => $::tsm::service_manifest_source,
  }

  service { $::tsm::service_name:
    ensure    => $::tsm::service_ensure,
    enable    => $::tsm::service_enable,
    manifest  => $tsm::service_manifest,
    subscribe => File[$::tsm::config],
  }

  File[$::tsm::service_script]   -> Service[$::tsm::service_name]
  File[$::tsm::service_manifest] -> Service[$::tsm::service_name]
}
