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
# Copyright 2013-2017 Toni Schmidbauer
#
class tsm::config {

  concat { $::tsm::config:
    ensure  => present,
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
  }

  if $::tsm::config_template {
    include tsm::config::full_template
  } else {
    include tsm::config::stanzas
  }

  concat::fragment { 'dsm_sys_local_banner':
    target  => $::tsm::config,
    content => "* settings included from dsm.sys.local (if any)\n",
    order   => '30',
  }
  file { "${::tsm::config}.local":
    ensure => file,
    owner  => 'root',
    group  => $::tsm::rootgroup,
    mode   => '0644',
  } ->
  concat::fragment { 'dsm_sys_local':
    target => $::tsm::config,
    source => "${::tsm::config}.local",
    order  => '31',
  }

  if $::tsm::config_opt_hash {
    file { $::tsm::config_opt:
      ensure  => file,
      replace => $::tsm::config_replace,
      owner   => 'root',
      group   => $::tsm::rootgroup,
      mode    => '0644',
      content => template($::tsm::config_opt_template),
    }
  }
  else {
    file { $::tsm::config_opt:
      ensure => present,
    }
  }
}
