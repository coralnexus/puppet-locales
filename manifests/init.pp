# Class: locales
#
#   This module manages system locales.
#
#   Adrian Webb <adrian.webb@coralnexus.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <example/params.json> for Hiera configurations)
#
# Actions:
#
#  Installs, configures, and manages locales.
#
# Requires:
#
# Sample Usage:
#
#   include locales
#
class locales inherits locales::params {

  $base_name = $locales::params::base_name

  #-----------------------------------------------------------------------------
  # Installation

  corl::package { $base_name:
    resources => {
      build_packages  => {
        name => $locales::params::build_package_names
      },
      common_packages => {
        name    => $locales::params::common_package_names,
        require => 'build_packages'
      },
      extra_packages  => {
        name    => $locales::params::extra_package_names,
        require => 'common_packages'
      }
    },
    defaults  => {
      ensure => $locales::params::package_ensure
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  $locales = $locales::params::locales

  corl::file { $base_name:
    resources => {
      config => {
        path    => $locales::params::config_file,
        content => template($locales::params::locale_template),
        notify  => Exec["${base_name}_generate"],
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Actions

  corl::exec { $base_name:
    resources => {
      generate => {
        command     => $locale_gen_command,
        refreshonly => true
      }
    },
    require => Corl::Package[$base_name]
  }
}
