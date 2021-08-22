/*
 * Copyright 2021 <?xml>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

int main (string[] args) {
	var app = new Gtk.Application ("page.codeberg.foreverxml.Random", ApplicationFlags.FLAGS_NONE);
	var about = new GLib.SimpleAction ("about", null);

	app.startup.connect (() => {
	    Gtk.Settings setter = Gtk.Settings.get_default ();
	    Settings settings = new Settings ("page.codeberg.foreverxml.Random");
	    bool dark = settings.get_boolean ("dark");
	    if (dark) {
            setter.gtk_application_prefer_dark_theme = true;
	    }
	    settings.changed.connect ( () => {
	        dark = settings.get_boolean ("dark");
	        if (dark) {
                setter.gtk_application_prefer_dark_theme = true;
	        } else {
                setter.gtk_application_prefer_dark_theme = false;
	        }
	    });
	    Adw.init ();
	});

    app.add_action (about);
	app.activate.connect (() => {
		var win = app.active_window;
		if (win == null) {
			win = new Random.Window (app);
			about.activate.connect (() => {((Random.Window) win).about ();});
		}
		win.present ();
	});

	return app.run (args);
}
