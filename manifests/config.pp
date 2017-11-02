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

  if $::tsm::config_template {

    # This is for backwards compatibility if users have used a
    # custom template.
    concat::fragment { 'dsm_sys_template':
      target  => $::tsm::config,
      content => template($::tsm::config_template),
      order   => '10',
    }

  } else {

    concat::fragment { 'dsm_sys_header':
      target  => $::tsm::config,
      content => template($::tsm::config_header_template),
      order   => '00',
    }
    concat::fragment { 'dsm_sys_options':
      target  => $::tsm::config,
      content => template($::tsm::config_global_template),
      order   => '20',
    }

    if empty($::tsm::stanzas) {
      
      # This is for backwards compatibity and uses the old tsm
      # class parameters to create a stanza
      tsm::stanza{$::tsm::server_name:
        comm_method           => $::tsm::comm_method,
        tcp_port              => $::tsm::tcp_port,
        tcp_server_address    => $::tsm::tcp_server_address,
        inclexcl              => $::tsm::inclexcl,
        inclexcl_source       => $::tsm::inclexcl_source,
        inclexcl_local        => $::tsm::inclexcl_local,
        inclexcl_hash         => $::tsm::inclexcl_hash,
        inclexcl_hash_source  => $::tsm::inclexcl_hash_source,
        inclexcl_replace      => $::tsm::inclexcl_replace,
        config_hash           => $::tsm::config_hash,
      }

    } else {

      create_resources('tsm::stanzas', $::tsm::stanzas)

    }

  }

  file { "${::tsm::config}.local":
    ensure => file,
    owner  => 'root',
    group  => $::tsm::rootgroup,
    mode   => '0644',
  }
  -> concat::fragment { 'dsm_sys_local':
    target => $::tsm::config,
    source => "${::tsm::config}.local",
    order  => '30',
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
