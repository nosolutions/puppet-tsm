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
#      Debian: ['TIVsm-API64', 'TIVsm-BA', 'gskcrypt64', 'gskssl64']
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
#      Linux: puppet://modules/tsm/dsmsched.redhat
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
#   Where to find the ERB template for dsm.sys
#   config_template - optional
#   Default: 'tsm/dsm.sys.erb'
#
# [*inclexcl*]
#   Path to the include/exclude file
#   inclexcl - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl
#
# [*inclexcl_local*]
#   Path to the local include/exclude file
#   inclexcl - optional
#   Default: /opt/tivoli/tsm/client/ba/bin/InclExcl.local
#
# [*inclexcl_replace*]
#   Whether or not to replace a existing InclExcl file
#   inclexcl - optional
#   Default: false
#
# [*inclexcl_source*]
#   Where to find a default include/exclude file
#   inclexcl_source - optional
#   Default:
#      Linux: puppet://modules/tsm/InclExcl.redhat
#      Solaris: puppet://modules/tsm/InclExcl.solaris
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
# === Examples
#
#  class { tsm:
#    tcp_server_address => 'tsmserver1'
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014 Toni Schmidbauer
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
  $service_ensure          = $::tsm::params::service_ensure,
  $service_name            = $::tsm::params::service_name,
  $service_manifest        = $::tsm::params::service_manifest,
  $service_manifest_source = $::tsm::params::service_manifest_source,
  $service_script          = $::tsm::params::service_script,
  $service_script_source   = $::tsm::params::service_script_source,
  $tsm_pwd                 = $::tsm::params::tsm_pwd,
  $initial_password        = $::tsm::params::initial_password,
  $set_initial_password    = $::tsm::params::set_initial_password,
  $config                  = $::tsm::params::config,
  $config_opt              = $::tsm::params::config_opt,
  $config_replace          = $::tsm::params::config_replace,
  $config_template         = $::tsm::params::config_template,
  $inclexcl                = $::tsm::params::inclexcl,
  $inclexcl_local          = $::tsm::params::inclexcl_local,
  $inclexcl_replace        = $::tsm::params::inclexcl_replace,
  $inclexcl_source         = $::tsm::params::inclexcl_source,
  $config_hash             = {},
  $config_opt_hash         = undef,
  $tcp_server_address,
  ) inherits tsm::params {

  validate_string($package_ensure)
  validate_string($tcp_server_address)
  validate_re($tcp_port,'\d+', "tcp_port option has to be a numeric value!")
  validate_string($comm_method)
  validate_array($packages)
  validate_string($package_uri)
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_string($service_name)
  validate_string($service_manifest_source)
  validate_absolute_path($service_script)
  validate_string($service_script_source)
  validate_absolute_path($tsm_pwd)
  validate_string($initial_password)
  validate_bool($set_initial_password)
  validate_absolute_path($config)
  validate_absolute_path($config_opt)
  validate_bool($config_replace)
  validate_string($config_template)
  validate_absolute_path($inclexcl)
  validate_absolute_path($inclexcl_local)
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
