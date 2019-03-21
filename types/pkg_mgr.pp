#
# == Type: Mock::Pkg_mgr
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


type Mock::Pkg_mgr = Enum[
    'dnf',
    'yum',
]
