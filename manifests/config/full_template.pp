# == Class: tsm::config::full_template
#
# This class is used if the user replaces the whole
# template and does not use the partials for header,
# global and stanza templates.
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013-2017 Toni Schmidbauer
#
class tsm::config::full_template {
  validate_string($::tsm::server_name)
  validate_string($::tsm::comm_method)
  validate_integer($::tsm::tcp_port, 65535, 1)
  validate_string($::tsm::tcp_server_address)
  validate_absolute_path($::tsm::inclexcl)
  validate_absolute_path($::tsm::inclexcl_local)
  validate_string($::tsm::inclexcl_source)
  validate_bool($::tsm::inclexcl_replace)

  concat::fragment { 'dsm_sys_template':
    target  => $::tsm::config,
    content => template($::tsm::config_template),
    order   => '10',
  }

  file { $::tsm::inclexcl:
    ensure  => file,
    replace => $::tsm::inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    source  => $::tsm::inclexcl_source,
  }

  file { $::tsm::inclexcl_hash_source:
    ensure  => file,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    content => template('tsm/inclexcl_hash.erb'),
  }

  file { $::tsm::inclexcl_local:
    ensure  => file,
    replace => $::tsm::inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
  }

}
