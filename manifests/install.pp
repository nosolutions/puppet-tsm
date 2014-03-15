# == Class: tsm::packages
#
# install tsm packages
#
# === Examples
#
#  class { tsm::install:
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013 Toni Schmidbauer
#
class tsm::install inherits tsm {

  tsm::installpkg { $::tsm::packages:
    ensure    => $::tsm::package_ensure,
    uri       => $::tsm::package_uri,
    adminfile => $::tsm::package_adminfile,
  }

  case $::osfamily {
    solaris: {
      Package['gsk8cry32'] ->
      Package['gsk8ssl32'] ->
      Package['TIVsmCapi'] ->
      Package['TIVsmCba']
    }
    default: {}
  }
}
