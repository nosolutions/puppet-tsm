# puppet-tsm [![Build Status] (https://secure.travis-ci.org/nosolutions/puppet-tsm.png)](http://travis-ci.org/nosolutions/puppet-tsm)


1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with tsm](#setup)
    * [What tsm affects](#what-tsm-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tsm](#beginning-with-tsm)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Install and manage TSM (Tivoli Storage Manager) client with puppet. It's
heavily inspired by the puppetlabs-ntp module.

This is currently work in progress!

##Module Description

This module handles installing, configuring and running the IBM Tivoli
Storage Manager (TSM) client on the following operating systems:

* RedHat Linux
* Solaris (TBD)

##Setup

### What tsm effects

* TSM package (TIVsm-Ba and TIVsm-API)
* TSM configuration files (dsm.sys and InclExcl)
* TSM service (dsmsched)

###Setup requirements

For RedHat Linux you need a yum repository that includes the rpm
packages from the IBM provided installation tar.gz.

This usually are

* TIVsm-API64.x86_64.rpm
* gskssl64-8.0.14.26.linux.x86_64.rpm
* gskcrypt64-8.0.14.26.linux.x86_64.rpm
* TIVsm-BA.x86_64.rpm

###Beginning with tsm

TBD

##Usage

TBD

##Reference

TBD

##Limitations

TBD

##Development

TBD
