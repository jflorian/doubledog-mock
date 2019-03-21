#
# == Type: Mock::Base_arch
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-ddolib Puppet module.
# Copyright 2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


type Mock::Base_arch = Enum[
    'aarch64',
    'armhfp',
    'i386',
    'ppc64',
    'ppc64le',
    's390x',
    'x86_64',
]
