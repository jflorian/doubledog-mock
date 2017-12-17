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
# [*config_opts*]
#   A hash-map of key/value pairs to go into mock's site-defaults.cfg filei to
#   override the upstream defaults.  The default is an empty map.  Neither
#   name nor value is validated in any way by this Puppet module.

#   TODO: handle nested keys e.g., plugin_conf::yum_cache_opts
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
        Hash[String[1], Data]       $config_opts,
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
        content   => template('mock/site-defaults.cfg.erb'),
        subscribe => Package[$packages],
    }

}
