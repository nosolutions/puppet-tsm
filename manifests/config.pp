# == Class: tsm::config
#
# Configures the tsm client
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
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::tsm::config_template)
  }

  file { $::tsm::inclexcl:
    ensure  => file,
    replace => $::tsm::inclexcl_replace,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $::tsm::inclexcl_source,
  }

  file { $::tsm::config_opt:
    ensure => file,
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
