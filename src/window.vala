/* window.vala
 *
 * Copyright 2021-2022 Forever XML
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

namespace Kleroterion {
	[GtkTemplate (ui = "/io/github/diegoivan/Kleroterion/window.ui")]
	public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Adw.ViewStack stack1;
        [GtkChild]
        private unowned Gtk.MenuButton menus;
        [GtkChild]
        private unowned RoulettePage roulette_page;
        public Gtk.Application app { get; construct; }

        public Window (Gtk.Application app) {
            Object (
                application: app,
                app: app
            );
        }

        static construct {
            typeof (NumberPage).ensure ();
            typeof (CoinPage).ensure ();
            typeof (RoulettePage).ensure ();
        }

		construct {
            // actions
		    ActionEntry[] actions = {
                {"about", about},
                {"shortcuts", shortcuts},
                {"quit", quit},
                {"change", change},
                {"menuopener", menuopener},
            };
            var actionc = new SimpleActionGroup ();
            actionc.add_action_entries (actions, this);

            insert_action_group ("app", actionc);

            app.set_accels_for_action ("app.number", {"<Primary><Shift>c"});
            app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
            app.set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
            app.set_accels_for_action ("app.change", {"<Primary>Tab"});
            app.set_accels_for_action ("app.menuopener", {"F10"});

	        this.present ();
	    }

	    private void about () {
	        string[] authors = {
                "Forever <forever@aroace.space>",
                "Diego Iván <diegoivan.mae@gmail.com>",
            };
	        // Translators: add your names and emails to this table, one per line as shown
	        string translators = _("translator-credits");

	        string[] artists = {"Forever <forever@aroace.space>", "Jakub Steiner <jimmac@gmail.com>"};
	        var win = new Adw.AboutWindow () {
                application_name = "Kleroterion",
                application_icon = "io.github.diegoivan.Kleroterion",
                version = "1.6",
                comments = _("Randomizing made easy") + ": " + _("A tool to pick a random number or list item. Pick what chore to do, a number between 1 and 100, whether or not to jump on your mom's bed, etc."),
                copyright = "Copyright © 2021-2022 Forever\nCopyright © 2023 Diego Iván",
                license_type = Gtk.License.AGPL_3_0,
                developer_name = "Forever; Diego Iván",
                developers = authors,
                artists = artists,
                translator_credits = translators,
                issue_url = "https://gitlab.gnome.org/diegoivanme/random/issues",
                transient_for = this
            };

            win.show ();
        }

        private void shortcuts () {
            var ui_builder = new Gtk.Builder.from_resource ("/page/codeberg/foreverxml/Random/shortcut.ui");
            var shortcuts_window = ui_builder.get_object ("shortcutting") as Gtk.ShortcutsWindow;

            if (shortcuts_window == null) {
                critical ("Failed to load shortcuts window");
                return;
            }

            shortcuts_window.transient_for = this;
            shortcuts_window.show ();
        }

        [GtkCallback]
        private void on_send_number_to_roulette (int min, int max) {
            roulette_page.add_from_range (min, max);
            stack1.visible_child = roulette_page;
        }

        private void quit () {
            this.close ();
            this.destroy ();
        }

        private void change () {
            Gtk.SelectionModel pages_model = stack1.pages;

            for (int i = 0; i < pages_model.get_n_items () - 1; i++) {
                if (pages_model.is_selected (i)) {
                    var next_page = (Adw.ViewStackPage) pages_model.get_object (i+1);
                    stack1.visible_child = next_page.child;
                    return;
                }
            }

            var first_page = (Adw.ViewStackPage) pages_model.get_object (0);
            stack1.visible_child = first_page.child;
        }

        private void menuopener () {
            menus.popup ();
        }
	}
}
