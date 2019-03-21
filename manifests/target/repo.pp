#
# == Define: mock::target::repo
#
# Defines a package repository to be made available for a mock build target.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-mock Puppet module.
# Copyright 2016-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define mock::target::repo (
        Enum['aarch64', 'armhfp', 'i386', 'ppc64', 'ppc64le', 's390x',
             'x86_64'] $base_arch,
        String[1] $family,
        String[1] $release,
        Optional[String[1]] $baseurl=undef,
        Integer[0] $cost=1000,
        Boolean $enabled=true,
        Mock::Failovermethod $failovermethod='roundrobin',
        Boolean $gpgcheck=false,
        Optional[String[1]] $gpgkey=undef,
        Optional[String[1]] $metalink=undef,
        Optional[String[1]] $mirrorlist=undef,
        String[1] $reponame=$title,
    ) {

    if $baseurl == undef and $metalink == undef and $mirrorlist == undef {
        fail("one of 'baseurl', 'metalink' or 'mirrorlist' must be set")
    }

    if $gpgcheck and $gpgkey == undef {
        fail("'gpgkey' must be set when 'gpgcheck' is true")
    }

    concat::fragment { "mock-${family}-${release}-${base_arch} ${title}":
        target  => "/etc/mock/${family}-${release}-${base_arch}.cfg",
        order   => '200',
        content => template('mock/repo.erb'),
    }

}
