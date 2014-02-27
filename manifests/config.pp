# == Class: tsm::config
#
# Configures the tsm client
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { tsm::config
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013 Toni Schmidbauer
#
class tsm::config {
  $tsm_port = hiera($tsm::tsm_host, 'unknown')

  file { "dsm.sys":
    ensure  => present,
    path    => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
    replace => $::tsm::replace_dsm_sys,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tsm/dsm.sys.erb')
  }

  file { 'InclExcl':
    ensure  => 'present',
    path    => '/opt/tivoli/tsm/client/ba/bin/InclExcl',
    replace => false,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
