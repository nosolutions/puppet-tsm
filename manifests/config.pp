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
class tsm::config inherits tsm {

  file { $::tsm::config:
    ensure  => file,
    path    => $::tsm::config,
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::tsm::config_template)
  }

  file { $::tsm::inclexcl:
    ensure  => file,
    path    => $::tsm::inclexcl,
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $::tsm::inclexcl_file,
  }
}
