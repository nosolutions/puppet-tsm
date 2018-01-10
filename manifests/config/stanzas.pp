# == Class: tsm::config::stanzas
#
# This class creates the dsm.sys config with the partial
# header, global and stanza templates.
#
# If the stanzas hash is not used it will create a single
# stanza from the tsm class parameters.
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013-2017 Toni Schmidbauer
#
class tsm::config::stanzas {

  concat::fragment { 'dsm_sys_header':
    target  => $::tsm::config,
    content => template($::tsm::config_header_template),
    order   => '00',
  }

  concat::fragment { 'dsm_sys_global':
    target  => $::tsm::config,
    content => template($::tsm::config_global_template),
    order   => '20',
  }

  if empty($::tsm::stanzas) {

    # create a single stanza from the tsm class params
    tsm::config::stanza{$::tsm::server_name:
      comm_method          => $::tsm::comm_method,
      tcp_port             => $::tsm::tcp_port,
      tcp_server_address   => $::tsm::tcp_server_address,
      inclexcl             => $::tsm::inclexcl,
      inclexcl_source      => $::tsm::inclexcl_source,
      inclexcl_local       => $::tsm::inclexcl_local,
      inclexcl_hash        => $::tsm::inclexcl_hash,
      inclexcl_hash_source => $::tsm::inclexcl_hash_source,
      inclexcl_replace     => $::tsm::inclexcl_replace,
      config_hash          => $::tsm::config_hash,
    }

  } else {

    create_resources('tsm::config::stanza', $::tsm::stanzas)

  }
}
