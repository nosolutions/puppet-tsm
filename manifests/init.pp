# == Class: tsm
#
# Full description of class tsm here.
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
  $package_ensure          = $::tsm::params::package_ensure,
  $tsm_host                = $::tsm::params::tsm_host,
  $tsm_port                = $::tsm::params::tsm_port,
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
  ) inherits tsm::params {

  validate_string($package_ensure)
  validate_string($tsm_host)
  validate_string($tsm_port)
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
  }

  anchor {'tsm::begin': } ->
  class { '::tsm::install': } ->
  class { '::tsm::config': } ->
  class { '::tsm::service': } ->
  anchor {'tsm::end': }
}
