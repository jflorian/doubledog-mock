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
# [*packages*]
#   An array of package names needed for the mock installation.
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
# Copyright 2014-2017 John Florian


class mock (
        Variant[Boolean, String[1]] $ensure,
        Array[String[1], 1]         $packages,
        Optional[String[1]]         $site_defaults=undef,
    ) {

    package { $packages:
        ensure => $ensure,
    }

    file { '/etc/mock/site-defaults.cfg':
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        source    => $site_defaults,
        subscribe => Package[$packages],
    }

}
