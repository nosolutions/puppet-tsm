# == Define: tsm::stanza
#
# Will create a stanza for each given servers in the dsm.sys file
#
# === Authors
#
# Andreas Zuber <zuber@puzzle.ch>
#
# === Copyright
#
# Copyright 2017-2017 Andreas Zuber
#
define tsm::stanza(
  $tcp_server_address,
  $server_name          = $name,
  $comm_method          = $::tsm::comm_method,
  $tcp_port             = $::tsm::tcp_port,
  $inclexcl             = "${::tsm::config_dir}/InclExcl_${name}",
  $inclexcl_source      = $::tsm::inclexcl_source,
  $inclexcl_local       = "${::tsm::config_dir}/InclExcl_${name}.local",
  $inclexcl_hash        = {},
  $inclexcl_hash_source = "${::tsm::config_dir}/InclExcl_${name}.hash",
  $inclexcl_replace     = $::tsm::inclexcl_replace,
  $config_hash          = {},
){
  validate_string($server_name)
  validate_string($comm_method)
  validate_integer($tcp_port, 65535, 1)
  validate_string($tcp_server_address)
  validate_absolute_path($inclexcl)
  validate_absolute_path($inclexcl_local)
  validate_string($inclexcl_source)
  validate_bool($inclexcl_replace)

  concat::fragment { "dsm_sys_stanza_${name}":
    target  => $::tsm::config,
    content => template($::tsm::config_stanza_template),
    order   => "20_${name}",
  }

  file { $inclexcl:
    ensure  => file,
    replace => $inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    source  => $inclexcl_source,
  }

  file { $inclexcl_hash_source:
    ensure  => file,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
    content => template('tsm/inclexcl_hash.erb'),
  }

  file { $inclexcl_local:
    ensure  => file,
    replace => $inclexcl_replace,
    owner   => 'root',
    group   => $::tsm::rootgroup,
    mode    => '0644',
  }
}
