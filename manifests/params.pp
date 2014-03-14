
class locales::params inherits locales::default {

  $base_name = 'locales'

  #--

  $build_package_names  = module_array('build_package_names')
  $common_package_names = module_array('common_package_names')
  $extra_package_names  = module_array('extra_package_names')
  $package_ensure       = module_param('package_ensure', 'present')

  #---

  $config_file = module_param('config_file')
  $locales     = module_array('locales', [ 'en_US.UTF-8 UTF-8' ])

  #---

  $locale_gen_command = module_param('locale_gen_command')
  $locale_template    = module_param('locale_template', 'locales/locale.gen.erb')
}
