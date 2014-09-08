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
