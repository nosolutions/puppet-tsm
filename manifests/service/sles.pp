# == Class: tsm::service::sles
#
# Manage tsm service on sles
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
# Sebastian Hempel <shempel@it-hempel.de>
#
# === Copyright
#
# Copyright 2014-2015 Toni Schmidbauer
# Copyright 2018 Sebastian Hempel
#
class tsm::service::sles {

  $service_script_mode = $::operatingsystemmajrelease ? {
    '12'    => '0644',
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
    subscribe  => Concat[$::tsm::config],
  }

  File[$::tsm::service_script] -> Service[$::tsm::service_name]
}
