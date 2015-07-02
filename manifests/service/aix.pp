# == Class: tsm::service::aix
#
# Manage tsm service on AIX
#

class tsm::service::aix {

  exec { 'mkssys':
    command => '/usr/bin/mkssys -s dsmsched -p /usr/bin/dsmc -u 0 -a "sched" -S -n 15 -f 9 -R -q',
    unless  => "/usr/bin/lssrc -s ${::tsm::service_name}";
  }

  service { $::tsm::service_name:
    ensure     => $::tsm::service_ensure,
    enable     => $::tsm::service_enable,
    hasstatus  => true,
    hasrestart => false,
    subscribe  => Concat[$::tsm::config],
  }

  Exec['mkssys'] -> Service[$::tsm::service_name]
}
