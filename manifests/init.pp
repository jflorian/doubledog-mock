# modules/mock/manifests/init.pp
#
# == Class: mock
#
# Manages mock on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2018 John Florian

class mock (
        Variant[Boolean, String[1]] $ensure,
        Array[String[1], 1]         $packages,
        Hash[String[1], Data]       $config_opts,
        Optional[String[1]]         $site_defaults=undef,
    ) {

    package { $packages:
        ensure => $ensure,
    }

    file { '/etc/mock/site-defaults.cfg':
        force     => true,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        content   => template('mock/site-defaults.cfg.erb'),
        subscribe => Package[$packages],
    }

}
