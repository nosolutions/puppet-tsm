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
# Copyright 2014 Toni Schmidbauer
#
class tsm::service::redhat {

  file { $::tsm::service_script:
    ensure  => file,
    path    => $::tsm::service_script,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => $::tsm::service_script_source,
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
