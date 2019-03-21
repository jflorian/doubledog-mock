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
# This file is part of the doubledog-mock Puppet module.
# Copyright 2014-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later

class mock (
        Variant[Boolean, String[1]] $ensure,
        Array[String[1], 1]         $packages,
        Hash[String[1], Data]       $config_opts,
        Optional[String[1]]         $site_defaults,
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
