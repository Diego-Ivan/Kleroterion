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
using GLib;
int main (string[] args) {
	Gtk.Application app = new Gtk.Application ("page.codeberg.foreverxml.Random", ApplicationFlags.FLAGS_NONE);

	SimpleAction about = new SimpleAction ("about", null);
	SimpleAction number = new SimpleAction ("number", null);
	SimpleAction remove = new SimpleAction ("remove", null);
	SimpleAction generate = new SimpleAction ("generate", null);
	SimpleAction shortcuts = new SimpleAction ("shortcuts", null);

	app.startup.connect (() => {
	    Adw.init ();
	});

    app.add_action (about);
    app.add_action (number);
    app.set_accels_for_action ("app.number", {"<Primary>m"});
    app.add_action (remove);
    app.set_accels_for_action ("app.remove", {"<Primary>r"});
    app.add_action (generate);
    app.set_accels_for_action ("app.generate", {"<Primary>g"});
    app.add_action (shortcuts);
    app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
	app.activate.connect (() => {
		var win = app.active_window;
		if (win == null) {
			win = new Random.Window (app);
			about.activate.connect (() => {((Random.Window) win).about ();});
			number.activate.connect (() => {((Random.Window) win).number ();});
			remove.activate.connect (() => {((Random.Window) win).remove ();});
			generate.activate.connect (() => {((Random.Window) win).generate ();});
			shortcuts.activate.connect (() => {((Random.Window) win).shortcuts ();});
		}
		win.present ();
	});

	return app.run (args);
}
