# == Define: tsm::config::stanza
#
# Will create a stanza fragment for inclusion in
# the dms.sys config file.
#
# === Parameters
#
# [*server_name*]
#   server_name - optional, server id in the config file
#   Default: tsm
#
# [*comm_method*]
#   TSM communication method
#   comm_method - optional
#   Default: TCPip
#
# [*tcp_port*]
#   TCP port used for connecting to the tsm server
#   tcp_port - optional
#   Default: 1500
#
# [*inclexcl*]
#   Path to the include/exclude file
#   inclexcl - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl_${name}
#
# [*inclexcl_hash*]
#   Hash from Hiera to build contents of inclexcl_hash_source
#   inclexcl_hash - optional
#   Default: {}
#
# [*inclexcl_hash_source*]
#   Path to the include/exclude file built from hiera
#   inclexcl_hash_source - optional
#   Default:
#      Redhat, Debian, Solaris:  /opt/tivoli/tsm/client/ba/bin/InclExcl_${name}.hash
#      AIX:                      /usr/tivoli/tsm/client/ba/bin64/InclExcl_${name}.hash
#
# [*inclexcl_local*]
#   Path to the local include/exclude file
#   inclexcl_local - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl_${name}.local
#
# [*inclexcl_replace*]
#   Whether or not to replace a existing InclExcl file
#   inclexcl_replace - optional
#   Default: false
#
# [*inclexcl_source*]
#   Where to find a default include/exclude file
#   inclexcl_source - optional
#   Default:
#      Redhat: puppet://modules/tsm/InclExcl.redhat
#      Debian: puppet://modules/tsm/InclExcl.debian
#      Solaris: puppet://modules/tsm/InclExcl.solaris
#
# [*config_hash*]
#   config_hash - hash with extended parameters
#     keys => value
#   Default: {}
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013-2017 Toni Schmidbauer
#
define tsm::config::stanza(
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
