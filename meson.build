project('random', ['c', 'vala'],
          version: '0.8.devel',
    meson_version: '>= 0.50.0',
  default_options: [ 'warning_level=2',
                   ],
)

i18n = import('i18n')
gnome = import('gnome')

subdir('data')
subdir('src')
subdir('po')

meson.add_install_script('build-aux/meson/postinstall.py') # TODO: flatpak manifest update when devel!!!!!
