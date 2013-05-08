
class locales::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $common_package_names = ['locales']

      $config_file         = '/etc/locale.gen'

      $locale_gen_command  = '/usr/sbin/locale-gen'
    }
  }
}
