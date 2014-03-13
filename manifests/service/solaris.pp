# == Class: tsm::service::solaris
#
# Manage the tsm service on solaris
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { sysdoc:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014 Toni Schmidbauer
#
class tsm::service::solaris inherits tsm {

  file { $::tsm::service_script:
    ensure  => file,
    path    => $::tsm::service_script,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => $::tsm::service_script_source,
  } ->
  file { $::tsm::service_manifest:
    ensure  => file,
    path    => $::tsm::service_manifest,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => $::tsm::service_manifest_source,
  } ->
  service { $::tsm::service_name:
    ensure   => $::tsm::service_ensure,
    enable   => $::tsm::service_enable,
    manifest => $tsm::service_manifest,
  }

}
