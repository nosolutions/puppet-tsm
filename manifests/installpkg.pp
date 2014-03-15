# == Class: tsm::installpkg
#
# Install a package on Linux and Solaris
#
# === Parameters
#
# [*ensure*]
#
#   Default: installed
#
# [*adminfile*]
#   Path to a solaris package admin file to enable
#   seemless installation.
#
#   Default: /dev/null
#
# [*uri*]
#   HTTP URI where we can find the package, only required for
#   solaris.
#
#   Default: ''
#
# === Examples
#
#  tsm::installpkg { 'TIVsmCba':
#    adminfile => '/var/sadm/install/admin/puppet',
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

# taken from
# http://fairwaytech.com/2013/05/gonzos-puppet-journey-updating-an-existing-package-on-solaris-10-using-puppet-2-7/
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

    }
    default: {
    }
  }
}
