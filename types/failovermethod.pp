#
# == Type: Mock::Failovermethod
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


type Mock::Failovermethod = Enum[
    'priority',
    'roundrobin',
]
