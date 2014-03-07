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
  $package_ensure  = $::tsm::params::package_ensure,
  $config_replace  = $::tsm::params::config_replace,
  $tsm_host        = $::tsm::params::tsm_host,
  $tsm_port        = $::tsm::params::tsm_port,
  $tsm_packages    = $::tsm::params::tsm_packages,
  $config          = $::tsm::params::config,
  $config_template = $::tsm::params::config_template,
  $inclexcl        = $::tsm::params::inclexcl,
  $inclexcl_file   = $::tsm::params::inclexcl_file,
  ) inherits tsm::params {

  validate_string($package_ensure)
  validate_bool($config_replace)
  validate_string($tsm_host)
  validate_string($tsm_port)
  validate_array($tsm_packages)
  validate_absolute_path($config)
  validate_string($config_template)
  validate_absolute_path($inclexcl)
  validate_string($config_file)

  anchor {'tsm::begin': } ->
  class { '::tsm::install': } ->
  class { '::tsm::config': } ->
  class { '::tsm::service': } ->
  anchor {'tsm::end': }
}
