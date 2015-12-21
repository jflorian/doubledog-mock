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
# Copyright 2014-2015 John Florian


define mock::target (
        $base_arch,
        $family,
        $legal_host_arches,
        $release,
        $target_arch,
        $ensure='present',
        $package_manager='dnf',
    ) {

    include '::mock'
    include '::mock::params'

    file { "/etc/mock/${family}-${release}-${base_arch}.cfg":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::mock::params::packages],
        content   => template("mock/${family}.erb"),
    }

}
