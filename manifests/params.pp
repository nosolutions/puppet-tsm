# == Class: tsm::params
#
# Default parameters for tsm
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
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013 Toni Schmidbauer
#
class tsm::params {
  $package_ensure = 'installed'

  $service_manage = false
  $service_ensure = 'running'
  $service_enable = true
  $service_name   = 'dsmsched'

  $tsm_host = 'unknown'
  $tsm_port = 'unknown'

  $config_replace = false

  $config          = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
  $config_template = 'tsm/dsm.sys.erb'

  case $::osfamily {
    redhat: {
      $tsm_packages   = ['TIVsm-BA']
      $service_script = '/etc/init.d/dsmsched'
      $service_file   = 'puppet:///modules/tsm/dsmsched.redhat'
      $inclexcl       = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
      $inclexcl_file  = 'puppet:///modules/tsm/InclExcl.redhat'
    }
    aix: {
      $tsm_package = []
      $tsm_package_uri = ''
    }
    solaris: {
      case $::kernelrelease {
        5.10: {
          $tsm_packages = ['TIVsm-BA']
          $tsm_package_uri = ''
        }
        5.11: {
        }
        default:{
          fail("Unsuported kernelrelease ${::kernelrelease} for osfamily ${::osfamily} in config.pp!")
        }
      }
    }
    default: {
      fail("Unsupport osfamily ${::osfamily} in config.pp!")
    }
  }
}
