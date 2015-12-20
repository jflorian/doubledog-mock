# modules/mock/manifests/init.pp
#
# == Class: mock
#
# Manages mock on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*ensure*]
#   Package state is to be 'installed' (default), 'absent', or any other value
#   appropiate to a Package resource type.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2015 John Florian


class mock (
        $ensure='installed',
    ) inherits ::mock::params {

    package { $::mock::params::packages:
        ensure => $ensure,
    }

}
