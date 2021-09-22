random_sources = [
  'main.vala',
  'window.vala',
  'config.vapi',
]

random_deps = [
  dependency('glib-2.0', version: '>= 2.66'),
  dependency('gio-2.0', version: '>= 2.66'),
  dependency('gdk-pixbuf-2.0'),
  dependency('gtk4', version: '>= 4.2.0'),
  dependency('libadwaita-1', version: '>= 1.0.0') # FIXME: newer GTK and adw
]

gnome = import('gnome')

random_sources += gnome.compile_resources('random-resources',
  'random.gresource.xml',
  c_name: 'randomgtk'
)

executable('randomgtk', random_sources,
  c_args: [
    '-DGETTEXT_PACKAGE="randomgtk"',
    '-DLOCALEDIR="@0@"'.format(localedir),
  ],
  vala_args: '--target-glib=2.50',  dependencies: random_deps,
  install: true,
)
