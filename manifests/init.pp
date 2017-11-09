# == Class: tsm
#
# Full description of class tsm here.
#
# === Parameters
#
# [*server_name*]
#   server_name - optional, server id in the config file
#   Default: tsm
#
# [*comm_method*]
#   TSM communication method
#   comm_method - optional
#   Default: TCPip
#
# [*tcp_port*]
#   TCP port used for connecting to the tsm server
#   tcp_port - optional
#   Default: 1500
#
# [*package_ensure*]
#   State of the tsm packages
#   package_ensure - optional
#   Default: 'installed'
#
# [*packages*]
#   List of tsm package to be installed
#   packages - optional
#   Default:
#      Redhat: ['TIVsm-BA']
#      Debian: ['tivsm-api64', 'tivsm-ba', 'gskcrypt64', 'gskssl64']
#      Solaris i386: ['gsk8cry32','gsk8cry64','gsk8ssl32','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
#      Solaris sparc: ['gsk8cry64','gsk8ssl64','TIVsmCapi', 'TIVsmCba']
#
# [*package_adminfile*]
#   Solaris SysV package admin file, required for an unattended installation
#   package_adminfile - optional
#   Default: /var/sadm/install/admin/puppet
#
# [*package_uri*]
#   HTTP URI where to find the package, required for Solaris
#   package_uri - optional
#   Default: http://server/pkgs/solaris/${::hardwareisa}/5.10
#
# [*service_manage*]
#   If we should manage the tsm service
#   service_manage - optional
#   Default: false
#
# [*service_ensure*]
#   Default state of the tsm service
#   service_manage - optional
#   Default: 'running'
#
# [*service_enable*]
#   Default state of the tsm service
#   service_manage - optional
#   Default: 'true'
#
# [*service_name*]
#   Name of the tsm service we manage
#   service_name - optional
#   Default:
#      Linux: dsmsched
#      Solaris: tsmsched
#
# [*service_manifest*]
#   Path to the solaris smf manifest for tsm
#   service_manifest - optional
#   Default: /var/svc/manifest/site/tsmsched.xml
#
# [*service_manifest_source*]
#   We do we get the solaris smf manifest from
#   service_manifest_source - optional
#   Default: puppet://modules/tsm/tsmsched.xml
#
# [*service_script*]
#   Start/stop script for the tsm service
#   service_script - optional
#   Default:
#      Linux: /etc/init.d/dsmsched
#      Solaris: /lib/svc/method/tsmsched
#
# [*service_script_source*]
#   Where to find the tsm service script for deployment
#   service_script_source - optional
#   Default:
#      Redhat: puppet://modules/tsm/dsmsched.redhat
#      Debian: puppet://modules/tsm/dsmsched.debian
#      Solaris: puppet://modules/tsm/tsmsched.solaris
#
# [*tsm_pwd*]
#   Path to the TSM password file
#   config - optional
#   Default: /etc/adsm/TSM.PWD
#
# [*initial_password*]
#   First time password for connecting to the tsm server
#   config - optional
#   Default: 'start'
#
# [*config_dir*]
#   Path where the per stanza InclExcl files will be deployed
#   config - optional
#   Default:
#     RedHat: /opt/tivoli/tsm/client/ba/bin
#     Debian: /opt/tivoli/tsm/client/ba/bin
#     Solaris: /opt/tivoli/tsm/client/ba/bin
#     AIX: /usr/tivoli/tsm/client/ba/bin64
#
# [*config*]
#   Path to dsm.sys
#   config - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/dsm.sys
#
# [*config_opt*]
#   Path to dsm.opt
#   config - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/dsm.opt
#
# [*config_replace*]
#   Whether or not to replace dsm.sys
#   config_replace - optional
#   Default: false
#
# [*config_template*]
#   Where to find the full ERB template for dsm.sys
#   config_template - optional
#   Default: 'tsm/dsm.sys.erb'
#
# [*config_header_template*]
#   Where to find the partial header ERB template for dsm.sys
#   config_template - optional
#   Default: tsm/dsm.sys_header.erb
#
# [*config_global_template*]
#   Where to find the partial global ERB template for dsm.sys
#   config_template - optional
#   Default: tsm/dsm.sys_global.erb
#
# [*config_stanza_template*]
#   Where to find the partial stanza ERB template for dsm.sys
#   config_template - optional
#   Default: tsm/dsm.sys_stanza.erb
#
# [*inclexcl*]
#   Path to the include/exclude file
#   inclexcl - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl
#
# [*inclexcl_hash*]
#   Hash from Hiera to build contents of inclexcl_hash_source
#   inclexcl_hash - optional
#   Default: {}
#
# [*inclexcl_hash_source*]
#   Path to the include/exclude file built from hiera
#   inclexcl_hash_source - optional
#   Default:
#      Redhat, Debian, Solaris:  /opt/tivoli/tsm/client/ba/bin/InclExcl.hash
#      AIX:                      /usr/tivoli/tsm/client/ba/bin64/InclExcl.hash
#
# [*inclexcl_local*]
#   Path to the local include/exclude file
#   inclexcl_local - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl.local
#
# [*inclexcl_replace*]
#   Whether or not to replace a existing InclExcl file
#   inclexcl_replace - optional
#   Default: false
#
# [*inclexcl_source*]
#   Where to find a default include/exclude file
#   inclexcl_source - optional
#   Default:
#      Redhat: puppet://modules/tsm/InclExcl.redhat
#      Debian: puppet://modules/tsm/InclExcl.debian
#      Solaris: puppet://modules/tsm/InclExcl.solaris
#
# [*config_global_hash*]
#   config_hash - hash with global parameters for the dms.sys file
#     keys => value
#   Default: {}
#
# [*config_hash*]
#   config_hash - hash with extended parameters
#     keys => value
#   Default: {}
#
# [*config_opt_hash*]
#   config_opt_hash - hash with opt parameters
#     keys => value
#   Default: undef
#
# [*tcp_server_address*]
#   TSM server used for this client
#   tcp_server_address - obligatory
#
# [*stanzas*]
#   Define multiple server stanzas as a hash.
#   config_hash - hash of tsm::config::stanza instances
#   Default: undef
#
# === Examples
#
#  Single server configuration:
#
#  class { tsm:
#    tcp_server_address => 'tsmserver1'
#  }
#
#  Configure multiple stanzas:
#
#  class { tsm:
#    stanzas => {
#      'tsmserver1' => {
#        'tcp_server_address' => 'tsmserver1'
#      },
#      'tsmserver2' => {
#        'tcp_server_address' => 'tsmserver2'
#      },
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014-2015 Toni Schmidbauer
#
class tsm (
  $server_name             = $name,
  $tcp_server_address      = undef,
  $comm_method             = $::tsm::params::comm_method,
  $tcp_port                = $::tsm::params::tcp_port,
  $package_ensure          = $::tsm::params::package_ensure,
  $packages                = $::tsm::params::packages,
  $package_adminfile       = $::tsm::params::package_adminfile,
  $package_uri             = $::tsm::params::package_uri,
  $package_provider        = $::tsm::params::package_provider,
  $service_manage          = $::tsm::params::service_manage,
  $service_ensure          = $::tsm::params::service_ensure,
  $service_enable          = $::tsm::params::service_enable,
  $service_name            = $::tsm::params::service_name,
  $service_manifest        = $::tsm::params::service_manifest,
  $service_manifest_source = $::tsm::params::service_manifest_source,
  $service_script          = $::tsm::params::service_script,
  $service_script_source   = $::tsm::params::service_script_source,
  $tsm_pwd                 = $::tsm::params::tsm_pwd,
  $initial_password        = $::tsm::params::initial_password,
  $set_initial_password    = $::tsm::params::set_initial_password,
  $config_dir              = $::tsm::params::config_dir,
  $config                  = $::tsm::params::config,
  $config_opt              = $::tsm::params::config_opt,
  $config_replace          = $::tsm::params::config_replace,
  $config_template         = undef,
  $config_header_template  = $::tsm::params::config_header_template,
  $config_global_template  = $::tsm::params::config_global_template,
  $config_stanza_template  = $::tsm::params::config_stanza_template,
  $rootgroup               = $::tsm::params::rootgroup,
  $inclexcl                = $::tsm::params::inclexcl,
  $inclexcl_hash           = {},
  $inclexcl_hash_source    = $::tsm::params::inclexcl_hash_source,
  $inclexcl_local          = $::tsm::params::inclexcl_local,
  $inclexcl_replace        = $::tsm::params::inclexcl_replace,
  $inclexcl_source         = $::tsm::params::inclexcl_source,
  $config_global_hash      = {},
  $config_hash             = {},
  $config_opt_hash         = undef,
  $stanzas                 = {},
  ) inherits tsm::params {

  validate_string($package_ensure)
  validate_array($packages)
  validate_string($package_uri)
  validate_bool($service_manage)
  validate_re($service_ensure,'^true$|^false$|^running$|^stopped$')
  validate_bool($service_enable)
  validate_string($service_name)
  validate_absolute_path($tsm_pwd)
  validate_string($initial_password)
  validate_bool($set_initial_password)
  validate_absolute_path($config)
  validate_absolute_path($config_opt)
  validate_bool($config_replace)
  validate_string($rootgroup)

  case $::osfamily {
    'solaris': {
      validate_absolute_path($package_adminfile)
      validate_absolute_path($service_manifest)
      validate_string($service_manifest_source)
      validate_absolute_path($service_script)
      validate_string($service_script_source)
      validate_string($package_provider)
    }
    'redhat': {
      validate_string($service_manifest_source)
      validate_absolute_path($service_script)
      validate_string($service_script_source)
    }
    'debian': {
      validate_string($service_manifest_source)
      validate_absolute_path($service_script)
      validate_string($service_script_source)
    }
    'AIX': {
      validate_string($package_provider)
    }
    default: {
      # do nothing
    }
  }

  anchor {'tsm::begin': }
  -> class { '::tsm::install': }
  -> class { '::tsm::config': }
  -> class { '::tsm::service': }
  -> anchor {'tsm::end': }
}
