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
# Copyright 2013-2015 Toni Schmidbauer
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

  $config_template     = 'tsm/dsm.sys.erb'
  $config_opt_template = 'tsm/dsm.opt.erb'
  $config_replace      = false

  $inclexcl_replace    = false

  case $::osfamily {
    redhat: {
      if $::operatingsystemmajrelease == '7' {
        $config                = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt            = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl              = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_local        = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages              = ['TIVsm-BA']
        $service_name          = 'dsmsched'
        $service_script        = '/etc/systemd/system/dsmsched.service'
        $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat7'
        $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
        $rootgroup             = 'root'
      }
      else {
        $config                = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt            = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl              = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_local        = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages              = ['TIVsm-BA']
        $service_name          = 'dsmsched'
        $service_script        = '/etc/init.d/dsmsched'
        $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat'
        $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
        $rootgroup             = 'root'
      }
    }
    debian: {
      $config                = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
      $config_opt            = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
      $inclexcl              = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
      $inclexcl_local        = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
      $packages              = ['tivsm-api64', 'tivsm-ba', 'gskcrypt64', 'gskssl64']
      $service_name          = 'dsmsched'
      $service_script        = '/etc/init.d/dsmsched'
      $service_script_source = 'puppet:///modules/tsm/dsmsched.debian'
      $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.debian'
      $rootgroup             = 'root'
    }
    solaris: {
      case $::hardwareisa {
        i386: {
          $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
          $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
          $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
          $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
          $packages                = ['gsk8cry32','gsk8cry64','gsk8ssl32','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
          $package_uri             = "http://server/pkgs/solaris/${::hardwareisa}/5.10"
          $package_adminfile       = '/var/sadm/install/admin/puppet'
          $package_provider        = 'sun'
          $service_name            = 'tsm'
          $service_manifest        = '/var/svc/manifest/site/tsmsched.xml'
          $service_manifest_source = 'puppet:///modules/tsm/tsmsched.xml'
          $service_script          = '/lib/svc/method/tsmsched'
          $service_script_source   = 'puppet:///modules/tsm/tsmsched.solaris'
          $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.solaris'
          $rootgroup               = 'root'
        }
        sparc: {
          $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
          $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
          $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
          $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
          $packages                = ['gsk8cry64','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
          $package_uri             = "http://server/pkgs/solaris/${::hardwareisa}/5.10"
          $package_adminfile       = '/var/sadm/install/admin/puppet'
          $package_provider        = 'sun'
          $service_name            = 'tsm'
          $service_manifest        = '/var/svc/manifest/site/tsmsched.xml'
          $service_manifest_source = 'puppet:///modules/tsm/tsmsched.xml'
          $service_script          = '/lib/svc/method/tsmsched'
          $service_script_source   = 'puppet:///modules/tsm/tsmsched.solaris'
          $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.solaris'
          $rootgroup               = 'root'
        }
        default:{
          fail("Unsupported hardwareisa ${::hardwareisa} for osfamily ${::osfamily} in config.pp!")
        }
      }
    }
    'AIX': {
      $config           = '/usr/tivoli/tsm/client/ba/bin64/dsm.sys'
      $config_opt       = '/usr/tivoli/tsm/client/ba/bin64/dsm.opt'
      $inclexcl         = '/usr/tivoli/tsm/client/ba/bin64/InclExcl'
      $inclexcl_local   = '/usr/tivoli/tsm/client/ba/bin64/InclExcl.local'
      $packages         = ['tivoli.tsm.client.ba.64bit.base']
      $package_provider = 'nim'
      $package_uri      = ''
      $service_name     = 'dsmsched'
      $inclexcl_source  = 'puppet:///modules/tsm/InclExcl.AIX'
      $rootgroup        = 'system'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily} in config.pp!")
    }
  }
}
