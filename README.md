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


**Defined types:**



### Classes


### Defined types


## Limitations

This module was developed for use on Fedora and RHEL hosts.  Given the very clean use of the data-in-modules paradigm, it should be very easy to adapt for other platforms.

## Development

Contributions are welcome via pull requests.
