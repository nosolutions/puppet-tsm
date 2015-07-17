# == Class: tsm::service::redhat
#
# Manage tsm service on redhat
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014-2015 Toni Schmidbauer
#
class tsm::service::redhat {

  $service_script_mode = $::operatingsystemmajrelease ? {
    '7'     => '0644',
    default => '0755'
  }

  file { $::tsm::service_script:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => $service_script_mode,
    source => $::tsm::service_script_source,
  }

  service { $::tsm::service_name:
    ensure     => $::tsm::service_ensure,
    enable     => $::tsm::service_enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File[$::tsm::config],
  }

  File[$::tsm::service_script] -> Service[$::tsm::service_name]
}
