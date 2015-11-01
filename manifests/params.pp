# modules/mock/manifests/params.pp
#
# Synopsis:
#       Parameters for the mock puppet module.


class mock::params {

    case $::operatingsystem {

        'Fedora': {

            $packages = [
                'mock',
            ]

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
