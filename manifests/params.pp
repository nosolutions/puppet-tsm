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


  $tsm_host = 'unknown'
  $tsm_port = 'unknown'

  $config          = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
  $config_template = 'tsm/dsm.sys.erb'
  $config_replace  = false

  $inclexcl       = '/opt/tivoli/tsm/client/ba/bin/InclExcl'

  case $::osfamily {
    redhat: {
      $packages              = ['TIVsm-BA']
      $service_name          = 'dsmsched'
      $service_script        = '/etc/init.d/dsmsched'
      $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat'
      $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
    }
    solaris: {
      case $::kernelrelease {
        5.10: {
          $packages                = ['gsk8cry32','gsk8cry64','gsk8ssl32','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
          $package_uri             = "http://sunkist6.eb.lan.at/pkgs/solaris/${::hardwareisa}/5.10"
          $package_adminfile       = '/var/sadm/install/admin/puppet'
          $service_name            = 'tsm'
          $service_manifest        = '/var/svc/manifest/site/tsmsched.xml'
          $service_manifest_source = 'puppet:///modules/tsm/tsmsched.xml'
          $service_script          = '/lib/svc/method/tsmsched'
          $service_script_source   = 'puppet:///modules/tsm/tsmsched.solaris'
          $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.solaris'
        }
        5.11: {
          fail("Solaris 11 is currently not supported")
        }
        default:{
          fail("Unsupported kernelrelease ${::kernelrelease} for osfamily ${::osfamily} in config.pp!")
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily} in config.pp!")
    }
  }
}
