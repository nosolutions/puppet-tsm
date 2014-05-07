# == Class: tsm::installpkg
#
# Install the tsm package on Linux and Solaris
#
# === Parameters
#
# [*ensure*]
#   What should be done with the package
#   Default: installed
#
# [*adminfile*]
#   Solaris sysv package adminfile for a seemless installation, only required
#   on Solaris.
#   Default: /dev/null
#
# [*uri*]
#   Where to get the TSM package from, only required on Solaris
#   Default: empty string
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2014 Toni Schmidbauer
#

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
      Package[$title] {
        source          => "$uri/${title}.pkg",
        adminfile       => $adminfile,
        install_options => ['-G', ],
        provider        => 'sun',
      }

    }
    default: {
    }
  }
}
