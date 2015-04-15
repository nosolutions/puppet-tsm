# == Class: tsm::params
#
# Default parameters for tsm
#
# For a documentation of all variables see init.pp
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
  $service_enable = true
  $service_ensure = 'running'

  # default password file
  $tsm_pwd              = '/etc/adsm/TSM.PWD'
  $initial_password     = 'start'
  $set_initial_password = true

  # default parameters fot dsm.sys
  $comm_method         = 'TCPip'
  $tcp_port            = '1500'

  $config              = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
  $config_opt          = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
  $config_template     = 'tsm/dsm.sys.erb'
  $config_opt_template = 'tsm/dsm.opt.erb'
  $config_replace      = false

  $inclexcl            = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
  $inclexcl_local      = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
  $inclexcl_replace    = false

  case $::osfamily {
    redhat: {
      if $::operatingsystemmajrelease == 7 {
        $packages              = ['TIVsm-BA']
        $service_name          = 'dsmsched'
        $service_script        = '/etc/systemd/system/dsmsched.service'
        $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat7'
        $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
      }
      else {
        $packages              = ['TIVsm-BA']
        $service_name          = 'dsmsched'
        $service_script        = '/etc/init.d/dsmsched'
        $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat'
        $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
      }
    }
    debian: {
      $packages              = ['tivsm-api64', 'tivsm-ba', 'gskcrypt64', 'gskssl64']
      $service_name          = 'dsmsched'
      $service_script        = '/etc/init.d/dsmsched'
      $service_script_source = 'puppet:///modules/tsm/dsmsched.debian'
      $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.debian'
    }
    solaris: {
      case $::hardwareisa {
        i386: {
          $packages                = ['gsk8cry32','gsk8cry64','gsk8ssl32','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
          $package_uri             = "http://server/pkgs/solaris/${::hardwareisa}/5.10"
          $package_adminfile       = '/var/sadm/install/admin/puppet'
          $service_name            = 'tsm'
          $service_manifest        = '/var/svc/manifest/site/tsmsched.xml'
          $service_manifest_source = 'puppet:///modules/tsm/tsmsched.xml'
          $service_script          = '/lib/svc/method/tsmsched'
          $service_script_source   = 'puppet:///modules/tsm/tsmsched.solaris'
          $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.solaris'
        }
        sparc: {
          $packages                = ['gsk8cry64','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
          $package_uri             = "http://server/pkgs/solaris/${::hardwareisa}/5.10"
          $package_adminfile       = '/var/sadm/install/admin/puppet'
          $service_name            = 'tsm'
          $service_manifest        = '/var/svc/manifest/site/tsmsched.xml'
          $service_manifest_source = 'puppet:///modules/tsm/tsmsched.xml'
          $service_script          = '/lib/svc/method/tsmsched'
          $service_script_source   = 'puppet:///modules/tsm/tsmsched.solaris'
          $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.solaris'
        }
        default:{
          fail("Unsupported hardwareisa ${::hardwareisa} for osfamily ${::osfamily} in config.pp!")
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily} in config.pp!")
    }
  }
}
