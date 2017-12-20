# mock

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with mock](#setup)
    * [Setup requirements](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Beyond the basic installation of the mock package, this Puppet module lets you easily manage the global `sites-default.cfg` configuration file as well as more specific build "target" configurations which effectively inherit, extend and override the global settings.

## Setup

### Setup Requirements

The requirements for this module are modest:
* the `puppetlabs-concat` module

### Beginning with mock

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

Typical use of this module involves including the `mock` class to install the package and set the global configuration defaults.  You can then declare zero or more `mock::target` instances to deploy configurations for specific build targets.  Each build-target configuration effectively inherits the global default values and can extend and override those settings.  Build targets can take zero or more package repositories that are declared via `mock::target::repo` but are most easily passed in via the `repos` parameter on the `mock::target` definition.

## Reference

**Classes:**

* [mock](#mock-class)

**Defined types:**

* [mock::target](#mocktarget-defined-type)


### Classes

#### mock class

This class manages the package installation and the global `sites-defaults.cfg` configuration file.  It will be included automatically by `mock::target` so if your site uses Hiera for class parameter values, it is unnecessary to explicitly include this class.

##### `config_opts`
A hash-map of key/value pairs to go into the `site-defaults.cfg` file to override the package defaults.  To remain as flexible as possible, neither name nor value is validated in any way by this Puppet module.


##### `ensure`
The desired package state.  This can be `installed` (default), `absent`, or any
other value appropriate to the Package resource type.


##### `packages`
An array of package names needed for the mock installation.  The default should be correct for supported platforms.


### Defined types

#### mock::target defined type

This defined type manages a build-target configuration file.

##### `namevar`
An arbitrary identifier for the target instance.  This has no effect on the naming of the configuration file.

##### `base_arch`
The base architecture for the build target.  This affects mock's configuration
for the package repositories so that mock can populate the build root.

##### `ensure`
This configuration file instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `family`
The build target`s distribution family.  E.g., `fedora` or `epel`.

##### `legal_host_arches`
To legally use this build target, the build host must be of a platform architecture contained in this array.

##### `package_manager`
The package manger to be used within mock`s chroot.  This can be either `dnf` (default) or `yum`.

##### `release`
The build target's distribution release.  E.g., `27`.

##### `repos`
A hash whose keys are package repository names and whose values are hashes comprising the same parameters you would otherwise pass to `mock::target::repo`.  When declaring repos this way, it is unnecessary to pass the `base_arch`, `family` and `release` parameters within the hash if those passed to `mock::target` match (as they usually should).

##### `target_arch`
The machine hardware architecture that mock is to target when building rpms.  This mostly affects code compilation.


## Limitations

This module was developed for use on Fedora and RHEL hosts.  Given the very clean use of the data-in-modules paradigm, it should be very easy to adapt for other platforms.

## Development

Contributions are welcome via pull requests.
