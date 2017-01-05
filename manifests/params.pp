# modules/mock/manifests/params.pp
#
# == Class: mock::params
#
# Parameters for the mock puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


class mock::params {

    case $::operatingsystem {

        'CentOS', 'Fedora': {

            $packages = 'mock'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
