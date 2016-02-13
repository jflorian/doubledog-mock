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
# [*site_defaults*]
#   Source URI providce mock's site-defaults configuration.  The default is to
#   use the one provided by the package.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2016 John Florian


class mock (
        $ensure='installed',
        $site_defaults=undef,
    ) inherits ::mock::params {

    package { $::mock::params::packages:
        ensure => $ensure,
    }

    file { '/etc/mock/site-defaults.cfg':
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        source    => $site_defaults,
        subscribe => Package[$::mock::params::packages],
    }

}