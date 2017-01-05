# modules/mock/manifests/target.pp
#
# == Define: mock::target
#
# Manages a build-target configuration file for mock.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the target instance.
#
# [*base_arch*]
#   The base architecture for the build target.  This affects mock's
#   configuration for yum repositories so that it can populate the build root
#   with the minimum package set plus all BuildRequires.
#
# [*family*]
#   The build target's distribution family.  E.g., 'fedora' or 'epel'.
#
# [*legal_host_arches*]
#   To legally use this build target, the build host must be of a platform
#   architecture contained in this list.
#
# [*release*]
#   The build target's distribution release.  E.g., '20'.
#
# [*repos*]
#   A hash whose keys are package repository names and whose values are hashes
#   comprising the same parameters you would otherwise pass to
#   Define[mock::target::repo].  When declaring repos this way, you do not
#   need to pass the "base_arch", "family" nor "release" parameters within the
#   hash if those passed to Define[mock::target] match (as they usually
#   should).
#
# [*target_arch*]
#   The machine hardware architecture that mock is to target when building
#   rpms.  This mostly affects code compilation.
#
# ==== Optional
#
# [*ensure*]
#   Configuration instance is to be 'present' (default) or 'absent'.
#
# [*package_manager*]
#   The package manger to be used within mock's chroot.  This can be either
#   'dnf' (default) or 'yum'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


define mock::target (
        $base_arch,
        $family,
        $legal_host_arches,
        $release,
        $target_arch,
        $ensure='present',
        $package_manager='dnf',
        $repos={},
    ) {

    include '::mock'
    include '::mock::params'

    ::concat { "/etc/mock/${family}-${release}-${base_arch}.cfg":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::mock::params::packages],
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
