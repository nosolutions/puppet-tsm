# == Class: tsm::installpkg
#
# Install a package on Linux, Solaris, AIX
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
#  class { sysdoc:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
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
define tsm::remove_solaris_package($adminfile) {
  exec { "uninstall_${name}":
    command   => "pkgrm -n -v -a ${adminfile} ${name}",
    logoutput => on_failure,
    onlyif    => "test `pkginfo -x | grep -w ${name} | awk 'END{print NR \"\"}'` -eq 1",
    path      => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
    require   => File["${adminfile}"],
  }
}

define tsm::installpkg (
  $ensure    = 'installed',
  $adminfile = '/dev/null',
  $uri        = '',
  ) {
  validate_string($ensure)
  validate_absolute_path($adminfile)
  validate_string($uri)

  package { $title:
    ensure => $ensure,
  }

  case $::osfamily {
    solaris: {
      # # first try to remove the package then install it
      # tsm::remove_solaris_package{ $title:
      #   adminfile => $adminfile,
      # }

      Package[$title] {
        source    => "$uri/${title}.pkg",
        adminfile => $adminfile,
        install_options => ['-G', ],
      }

      Package['gsk8cry32'] ->
      Package['gsk8ssl32'] ->
      Package['TIVsmCapi'] ->
      Package['TIVsmCba']
    }
    default: {
    }
  }
}
