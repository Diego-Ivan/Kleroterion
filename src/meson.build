random_sources = [
  'main.vala',
  'window.vala',
]

random_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('libhandy-1', version: '>= 1.0')
]

gnome = import('gnome')

random_sources += gnome.compile_resources('random-resources',
  'random.gresource.xml',
  c_name: 'random'
)

executable('randomgtk', random_sources,
  vala_args: '--target-glib=2.50',  dependencies: random_deps,
  install: true,
)
