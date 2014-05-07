# == Class: tsm
#
# Full description of class tsm here.
#
# === Parameters
#
# [*server_name*]
#   server_name - optional, server id in the config file
#
# [*comm_method*]
#   comm_method - optional
#
# [*tcp_port*]
#   tcp_port - optional
#
# [*package_ensure*]
#   package_ensure - optional
#
# [*packages*]
#   packages - optional
#
# [*package_adminfile*]
#   package_adminfile - optional
#
# [*package_uri*]
#   package_uri - optional
#
# [*service_manage*]
#   service_manage - optional
#
# [*service_name*]
#   service_name - optional
#
# [*service_manifest*]
#   service_manifest - optional
#
# [*service_manifest_source*]
#   service_manifest_source - optional
#
# [*service_script*]
#   service_script - optional
#
# [*service_script_source*]
#   service_script_source - optional
#
# [*config*]
#   config - optional
#
# [*config_replace*]
#   config_replace - optional
#
# [*config_template*]
#   config_template - optional
#
# [*inclexcl*]
#   inclexcl - optional
#
# [*inclexcl_source*]
#   inclexcl_source - optional
#
# [*config_hash*]
#   config_hash - hash with extended parameters
#     keys => value
#
# [*tcp_server_address*]
#   tcp_server_address - obligatory
#
#
# === Examples
#
#  class { tsm:
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class tsm (
  $server_name             = $name,
  $comm_method             = $::tsm::params::comm_method,
  $tcp_port                = $::tsm::params::tcp_port,
  $package_ensure          = $::tsm::params::package_ensure,
  $packages                = $::tsm::params::packages,
  $package_adminfile       = $::tsm::params::package_adminfile,
  $package_uri             = $::tsm::params::package_uri,
  $service_manage          = $::tsm::params::service_manage,
  $service_name            = $::tsm::params::service_name,
  $service_manifest        = $::tsm::params::service_manifest,
  $service_manifest_source = $::tsm::params::service_manifest_source,
  $service_script          = $::tsm::params::service_script,
  $service_script_source   = $::tsm::params::service_script_source,
  $config                  = $::tsm::params::config,
  $config_replace          = $::tsm::params::config_replace,
  $config_template         = $::tsm::params::config_template,
  $inclexcl                = $::tsm::params::inclexcl,
  $inclexcl_replace        = $::tsm::params::inclexcl_replace,
  $inclexcl_source         = $::tsm::params::inclexcl_source,
  $config_hash             = {},
  $tcp_server_address,

  ) inherits tsm::params {

  validate_string($package_ensure)
  validate_string($tcp_server_address)
  validate_string($tcp_port)
  validate_string($comm_method)
  validate_array($packages)
  validate_string($package_uri)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_manifest_source)
  validate_absolute_path($service_script)
  validate_string($service_script_source)
  validate_absolute_path($config)
  validate_bool($config_replace)
  validate_string($config_template)
  validate_absolute_path($inclexcl)
  validate_string($inclexcl_source)

  case $::osfamily {
    solaris: {
      validate_absolute_path($package_adminfile)
      validate_absolute_path($service_manifest)
    }
    default: {
      # do nothing
    }
  }

  anchor {'tsm::begin': } ->
  class { '::tsm::install': } ->
  class { '::tsm::config': } ->
  class { '::tsm::service': } ->
  anchor {'tsm::end': }
}
