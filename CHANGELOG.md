## 2014-??-?? release ??
###Summary

Integrated RedHat 7 support, kindly provided by Lorenzo Dalrio.

###Features

- we now use a systemd service under redhat 7 for starting/stopping
  the dsmc scheduler

## 2014-11-26 release 0.3.1
###Summary

Integrated Debian 7 support, kindly provided by David orn Johannsson.

###Features
- this module now supports Debian 7

###Bugfixes
- various lint and documentation fixes
- removed deprecated Modulefile

## 2014-09-08 release 0.2.2
###Summary

create tag after changing the modulefile

## 2014-09-08 release 0.2.1
###Summary

fixed a mistake in the changelog

## 2014-09-08 release 0.2.0

manage dsm.opt, solaris inclexcl fixes

###Bugfixes
- removed /etc/shadow from solaris exclude list
  so the behavior is the same as on redhat

###Features
- dsm.opt is now managed via ::tsm::config_opt_hash

## 2014-07-23 release 0.1.0
###Summary
Support multiple values for the inclexcl option in config_hash

####Features
- Multiple values for option in config_hash

## 2014-06-12 release 0.0.2
###Summary
Documentation update (README.md, init.pp)

## 2014-06-11 Initial release 0.0.1
###Summary
Initial release of the module
