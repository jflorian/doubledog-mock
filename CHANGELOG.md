<!--
This file is part of the doubledog-mock Puppet module.
Copyright 2018-2020 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v1.3.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [1.5.0] 2020-12-15
### Added
- CentOS 8 support
- Fedora 32-33 support
### Changed
- dependency on `puppetlabs/concat` now allows version 6
### Removed
- Fedora 28-31 support

## [1.4.0] 2019-03-21
### Added
- Fedora 29 support
- `Mock::Pkg_mgr` data type
- `Mock::Failovermethod` data type
- `Mock::Base_arch` data type
- `mock::targets` parameter
- `mock::target_defaults` parameter
- `mock::target::repo_defaults` parameter
### Changed
- switch from Hiera 4 to Hiera 5
- dependency on `puppetlabs/concat` now allows version 5
- leverage `Ddolib::File::Ensure::Limited` type
### Removed
- `python3-pkgversion-macros` from chroot setup
- Fedora 26-27 support

## [1.3.0 and prior] 2018-12-15

This and prior releases predate this project's keeping of a formal CHANGELOG.  If you are truly curious, see the Git history.
