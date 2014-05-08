# == Class: tsm::params
#
# Default parameters for tsm
#
# === Variables
#
# [*package_ensure*]
#   Package state
#   Default: 'installed'
#
# [*service_manage*]
#   Should we manage the tsm scheduler service
#   Default: false
#
# [*service_ensure*]
#   If we manage the service, what state do we want?
#   Default: running
#
# [*service_enable*]
#   Should the service start on boot
#   Default: true
#
# [*tsm_host*]
#   TSM Server to use
#   Default: unknown
#
# [*tsm_port*]
#   TCP port on the server to connect to
#   Default: unknown
#
# [*config*]
#   Path to dsm.sys
#   Default: /opt/tivoli/tsm/client/ba/bin/dsm.sys
#
# [*config_template*]
#   Which template to use for dsm.sys
#   Default: tsm/config.sys.erb
#
# [*config_replace*]
#   Should we replace dsm.sys
#   Default: false
#
# [*inclexcl*]
#   Path to the include/exclude file
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl
#
# [*inclexcl_replace*]
#   Should we replace the include/exclude file
#   Default: false
#
# [*packages*]
#   Packages to be installed
#   Default:
#     Redhat: TIVsm-BA
#     Solaris i386: gsk8cry32,gsk8cry64,gsk8ssl32,gsk8ssl64,TIVsmCapi,TIVsmCba
#     Solaris sparc: gsk8cry64,gsk8ssl64,TIVsmCapi,TIVsmCba
#
# [*package_uri*]
#   HTTP URI where to find the package, required for Solaris
#   Default: http://server/pkgs/solaris/${::hardwareisa}/5.10
#
# [*package_adminfile*]
#   Solaris SysV package admin file, required for an unattended installation
#   Default: /var/sadm/install/admin/puppet
#
# [*service_name*]
#   Name of the TSM service to managen
#   Default:
#     RedHat: dsmsched
#     Solaris: tsm
#
# [*service_manifest*]
#   Solaris SMF manifiest
#   Default: /var/svc/manifest/site/tsmsched.xml
#
# [*service_manifest_source*]
#   Solaris SMF manifest source to be imported
#   Default: puppet:///modules/tsm/tsmsched.xml
#
# [*service_script*]
#   Script for restarting the TSM Scheduler
#   Default:
#     RedHat: /etc/init.d/dsmsched
#     Solaris: /lib/svc/method/tsmsched
#
# [*serivce_script_source*]
#   Script source for restarting the TSM Scheduler
#   Default:
#     RedHat: puppet:///modules/tsm/dsmsched.redhat
#     Solaris: puppet:///modules/tsm/tsmsched.solaris
#
# [*inclexcl_source*]
#   Source for the include/exclude file
#   Default:
#     RedHat: puppet:///modules/tsm/InclExcl.redhat
#     Solaris: puppet:///modules/tsm/InclExcl.solaris
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

  # default parameters fot dsm.sys
  $comm_method        = 'TCPip'
  $tcp_port           = '1500'

  $config          = '/opt/tivoli/tsm/client/ba/bin/dsm.sys'
  $config_template = 'tsm/dsm.sys.erb'
  $config_replace  = false

  $inclexcl         = '/opt/tivoli/tsm/client/ba/bin/InclExcl'
  $inclexcl_replace = false

  case $::osfamily {
    redhat: {
      $packages              = ['TIVsm-BA']
      $service_name          = 'dsmsched'
      $service_script        = '/etc/init.d/dsmsched'
      $service_script_source = 'puppet:///modules/tsm/dsmsched.redhat'
      $inclexcl_source       = 'puppet:///modules/tsm/InclExcl.redhat'
    }
    solaris: {
      case $::hardwareisa {
        i386: {
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
          fail("Unsupported kernelrelease ${::kernelrelease} for osfamily ${::osfamily} in config.pp!")
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily} in config.pp!")
    }
  }
}
