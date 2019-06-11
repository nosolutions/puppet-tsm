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
  $tsm_pwd_kdb          = '/etc/adsm/TSM.KDB'
  $initial_password     = 'start'
  $set_initial_password = true

  # default parameters for dsm.sys
  $comm_method         = 'TCPip'
  $tcp_port            = '1500'

  $config_header_template = 'tsm/dsm.sys_header.erb'
  $config_global_template = 'tsm/dsm.sys_global.erb'
  $config_stanza_template = 'tsm/dsm.sys_stanza.erb'
  $config_opt_template    = 'tsm/dsm.opt.erb'
  $config_replace         = false

  $inclexcl_replace    = false

  case $::osfamily {
    'redhat': {
      if $::operatingsystemmajrelease == '7' {
        $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
        $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
        $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages                = ['TIVsm-BA']
        $package_adminfile       = undef
        $package_uri             = undef
        $package_provider        = undef
        $service_name            = 'dsmsched'
        $service_script          = '/etc/systemd/system/dsmsched.service'
        $service_script_source   = 'puppet:///modules/tsm/dsmsched.redhat7'
        $service_manifest        = undef
        $service_manifest_source = undef
        $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.redhat'
        $rootgroup               = 'root'
      }
      else {
        $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
        $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
        $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages                = ['TIVsm-BA']
        $package_adminfile       = undef
        $package_uri             = undef
        $package_provider        = undef
        $service_name            = 'dsmsched'
        $service_script          = '/etc/init.d/dsmsched'
        $service_script_source   = 'puppet:///modules/tsm/dsmsched.redhat'
        $service_manifest        = undef
        $service_manifest_source = undef
        $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.redhat'
        $rootgroup               = 'root'
      }
    }
    'debian': {
      $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
      $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
      $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
      $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
      $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
      $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
      $packages                = ['tivsm-api64', 'tivsm-ba', 'gskcrypt64', 'gskssl64']
      $package_adminfile       = undef
      $package_uri             = undef
      $package_provider        = undef
      $service_name            = 'dsmsched'
      $service_script          = '/etc/init.d/dsmsched'
      $service_script_source   = 'puppet:///modules/tsm/dsmsched.debian'
      $service_manifest        = undef
      $service_manifest_source = undef
      $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.debian'
      $rootgroup               = 'root'
    }
    'suse': {
      if $::operatingsystemmajrelease == '12' {
        $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
        $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
        $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages                = ['TIVsm-BA']
        $package_adminfile       = undef
        $package_uri             = undef
        $package_provider        = undef
        $service_name            = 'dsmcad'
        $service_script          = '/etc/systemd/system/dsmsched.service'
        $service_script_source   = 'puppet:///modules/tsm/dsmsched.sles12'
        $service_manifest        = undef
        $service_manifest_source = undef
        $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.sles'
        $rootgroup               = 'root'
      }
      else {
        $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
        $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
        $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
        $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
        $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
        $inclexcl_local          = '/opt/tivoli/tsm/client/ba/bin/InclExcl.local'
        $packages                = ['TIVsm-BA']
        $package_adminfile       = undef
        $package_uri             = undef
        $package_provider        = undef
        $service_name            = 'dsmsched'
        $service_script          = '/etc/init.d/dsmsched'
        $service_script_source   = 'puppet:///modules/tsm/dsmsched.sles'
        $service_manifest        = undef
        $service_manifest_source = undef
        $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.sles'
        $rootgroup               = 'root'
      }
    }
    'solaris': {
      case $::hardwareisa {
        'i386': {
          $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
          $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
          $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
          $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
          $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
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
        'sparc': {
          $config_dir              = '/opt/tivoli/tsm/client/ba/bin'
          $config                  = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
          $config_opt              = '/opt/tivoli/tsm/client/ba/bin/dsm.opt'
          $inclexcl                = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
          $inclexcl_hash_source    = '/opt/tivoli/tsm/client/ba/bin/InclExcl.hash'
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
      $config_dir              = '/usr/tivoli/tsm/client/ba/bin64'
      $config                  = '/usr/tivoli/tsm/client/ba/bin64/dsm.sys'
      $config_opt              = '/usr/tivoli/tsm/client/ba/bin64/dsm.opt'
      $inclexcl                = '/usr/tivoli/tsm/client/ba/bin64/InclExcl'
      $inclexcl_hash_source    = '/usr/tivoli/tsm/client/ba/bin64/InclExcl.hash'
      $inclexcl_local          = '/usr/tivoli/tsm/client/ba/bin64/InclExcl.local'
      $packages                = ['tivoli.tsm.client.ba.64bit.base']
      $package_provider        = 'nim'
      $package_uri             = undef
      $package_adminfile       = undef
      $service_name            = 'dsmsched'
      $service_manifest        = undef
      $service_manifest_source = undef
      $service_script          = undef
      $service_script_source   = undef
      $inclexcl_source         = 'puppet:///modules/tsm/InclExcl.AIX'
      $rootgroup               = 'system'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily} in params.pp!")
    }
  }
}
