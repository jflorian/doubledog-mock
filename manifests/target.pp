# modules/mock/manifests/target.pp
#
# == Define: mock::target
#
# Manages a build-target configuration file for mock.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


define mock::target (
        String[1] $base_arch,
        String[1] $family,
        Array[String[1]] $legal_host_arches,
        String[1] $release,
        String[1] $target_arch,
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        Enum['dnf', 'yum'] $package_manager='dnf',
        Hash[String[1], Hash] $repos={},
    ) {

    include '::mock'

    ::concat { "/etc/mock/${family}-${release}-${base_arch}.cfg":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::mock::packages],
    }

    ::concat::fragment { "/etc/mock/${family}-${release}-${base_arch}.cfg top":
        target  => "/etc/mock/${family}-${release}-${base_arch}.cfg",
        order   => '100',
        content => template("mock/${family}.erb"),
    }

    ::concat::fragment { "/etc/mock/${family}-${release}-${base_arch}.cfg bottom":
        target  => "/etc/mock/${family}-${release}-${base_arch}.cfg",
        order   => '999',
        content => "\n\"\"\"\n",
    }

    create_resources(
        ::mock::target::repo,
        $repos,
        # These defaults are nice because ordinarily the repo is always going
        # to match the target.  (The repo configuration generally doesn't need
        # them, but Define[mock::target::repo] does to uniquely identify each.
        {
            base_arch => $base_arch,
            family    => $family,
            release   => $release,
        }
    )

}
