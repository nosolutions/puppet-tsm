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
# Copyright 2013-2015 Toni Schmidbauer
#
class tsm::config {
  concat { $::tsm::config:
    ensure  => present,
    replace => $::tsm::config_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
  }

  concat::fragment { 'dsm_sys_template':
    target  => $::tsm::config,
    content => template($::tsm::config_template),
    order   => '01',
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
    order  => '02',
  }

  file { $::tsm::inclexcl:
    ensure  => file,
    replace => $::tsm::inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    source  => $::tsm::inclexcl_source,
  }

  file { $::tsm::inclexcl_local:
    ensure  => file,
    replace => $::tsm::inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    content => template('tsm/inclexcl.local.erb'),
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
