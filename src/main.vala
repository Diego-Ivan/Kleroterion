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
// TODO better close button
int main (string[] args) {
	// Init gettext
	Intl.setlocale (LocaleCategory.ALL, "");
	Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
	Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
	Intl.textdomain (GETTEXT_PACKAGE);

	Gtk.Application app = new Gtk.Application ("page.codeberg.foreverxml.Random", ApplicationFlags.FLAGS_NONE);

    string[] actionx = {"about", "number", "remove", "generate", "shortcuts", "quit", "change", "menuopener", "help", "copy"};
    SimpleAction[] actions = new SimpleAction[9];
    for (int i = 0; i < actionx.length; i++) {
        actions[i] = new SimpleAction (actionx[i], null);
        app.add_action (actions[i]);
    }
	app.startup.connect (() => {
	    Adw.init ();
	});
    app.set_accels_for_action ("app.number", {"<Primary>m"});
    app.set_accels_for_action ("app.remove", {"<Primary>d"});
    app.set_accels_for_action ("app.generate", {"<Primary>g"});
    app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
    app.set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
    app.set_accels_for_action ("app.change", {"<Primary>Tab"});
    app.set_accels_for_action ("app.menuopener", {"F10"});
    app.set_accels_for_action ("app.copy", {"<Primary><Shift>c"});
	app.activate.connect (() => {
		var win = app.active_window;
		if (win == null) {
			win = new Random.Window (app);
			actions[0].activate.connect (() => {((Random.Window) win).about ();});
			actions[1].activate.connect (() => {((Random.Window) win).number ();});
			actions[2].activate.connect (() => {((Random.Window) win).remove ();});
			actions[3].activate.connect (() => {((Random.Window) win).generate ();});
			actions[4].activate.connect (() => {((Random.Window) win).shortcuts ();});
			actions[5].activate.connect (() => {((Random.Window) win).quit ();});
			actions[6].activate.connect (() => {((Random.Window) win).change ();});
			actions[7].activate.connect (() => {((Random.Window) win).menuopener ();});
			actions[8].activate.connect (() => {((Random.Window) win).help ();});
			actions[9].activate.connect (() => {((Random.Window) win).copy ();});
		}
		win.present ();
	});

	return app.run (args);
}
