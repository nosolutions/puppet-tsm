## 2016-04-14 release 1.1.1
### Summary

Fix usage of InclExcl file in the default dsm.sys (thanks to Gerben
Welter). Up until now `InclExcl.local` was include in the dsm.sys
template, this should have been `InclExcl`. 

Cleanup if inherits usage and fixes for puppet 4.

##Bugfixes
- puppet 4 tests fail (GH-30)
- remove inherits from manifests (GH-27)
- use correct config_opt_hash variable dsm.opt.erb template

## 2015-09-09 release 1.1.0
### Summary

Added AIX support and run test with the future parser enabled.

If there is no `dsm.opt` this release will create an emtpy one to
avoid the warning message

`ANS0990W Options file '/opt/tivoli/tsm/client/ba/bin/dsm.opt' could not be found`

and return code `8`.

###Features
- added AIX 7.1 support provided by purgemerge (mrvdijk at gmail.com)
- Added Puppet 4 to the test matrix
- Create empty dsm.opt to avoid TSM warnings

###Bugfixes

- AIX support (GH-20)
- Puppet master reporting issue with config_opt_hash (GH-19)
- Issue with service dependency on dsm.sys (GH-14)
- Create empty dsm.opt to avoid return code 8 (GH-24)

## 2015-04-29 release 1.0.1
###Summary

Fixed module compatibility matrix (RedHat 7).

## 2015-04-29 release 1.0.0
###Summary

The tsm scheduler gets now restarted on config file changes. We've also
included inclexcl.local in the default dsm.sys template. This means
when upgrading to 1.0.0 the dsm scheduler is going to be restarted.

###Features
- we now use a systemd service under redhat 7 for starting/stopping
  the dsmc scheduler, kindly provided by Lorenzo Dalrio (GH-9).
- restart the tsm scheduler on config file changes (GH-11)
- added inclexcl.local to the default dsm.sys options (GH-8)

###Bugfixes

- option config_replace is now also valid for dsm.sys (GH-12)

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
