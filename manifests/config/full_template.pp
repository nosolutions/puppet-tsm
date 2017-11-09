# == Class: tsm::config
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
