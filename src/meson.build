random_sources = [
  'main.vala',
  'window.vala',
]

random_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk4', version: '>= 4.2.0'),
  dependency('libadwaita-1') # FIXME: newer GTK and adw
]

gnome = import('gnome')

random_sources += gnome.compile_resources('random-resources',
  'random.gresource.xml',
  c_name: 'randomgtk'
)

executable('randomgtk', random_sources,
  vala_args: '--target-glib=2.50',  dependencies: random_deps,
  install: true,
)
