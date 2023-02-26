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
using Gtk;
using GLib;
namespace Random {
	[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/window.ui")]
	public class Window : Adw.ApplicationWindow {
        [GtkChild] private unowned Button genc;
        [GtkChild] private unowned Label endc;
        // [GtkChild] private unowned Button cf;
        // [GtkChild] private unowned Label cl;
        [GtkChild] private unowned Adw.ViewStackPage rou;
        [GtkChild] private unowned Adw.ViewStackPage numstack;
        [GtkChild] private unowned Adw.ViewStackPage coinpage;
        [GtkChild] private unowned Adw.ViewStack stack1;
        [GtkChild] private unowned MenuButton menus;
        [GtkChild] private unowned Revealer rourev;
        // [GtkChild] private unowned Revealer coinrev;
        [GtkChild] private new unowned Adw.ViewSwitcherTitle title;
        [GtkChild] private unowned Adw.ViewSwitcherBar bar;
        // [GtkChild] private unowned ListBox robox;
        [GtkChild] private unowned RouletteList roulette_list;
        // Translators: If the language is in Latin, leave these be. If it is not, insert names here, and don't translate the strings.
        private ActionEntry[] actions;
        private SimpleActionGroup actionc = new SimpleActionGroup ();
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
        }

		construct {
            // actions
		    actions = {
                {"about", about},
                {"shortcuts", shortcuts},
                {"quit", quit},
                {"change", change},
                {"menuopener", menuopener},
                {"help", help},
            };
            actionc.add_action_entries (actions, this);
            insert_action_group ("app", actionc);

            app.set_accels_for_action ("app.number", {"<Primary><Shift>c"});
            app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
            app.set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
            app.set_accels_for_action ("app.change", {"<Primary>Tab"});
            app.set_accels_for_action ("app.menuopener", {"F10"});

	        title.notify["title-visible"].connect (() => {
	            if (title.get_title_visible () == true) {
	                bar.set_reveal (true);
	            } else {
	                bar.set_reveal (false);
	            }
	        });
	        bar.set_reveal (true);

	        // roulette
	        genc.clicked.connect (() => {
                rourev.set_reveal_child (false);
	            Timeout.add (250, () => {
	            string txt = roulette_list.pick_random ();
	            if (txt == "Hey adora") {
	                txt = "Catra!? What are you doing here?";
	            }
                endc.set_label (txt);
                rourev.set_reveal_child (true);
                });
	        });

	        this.present ();
	    }

	    private void about () {
	        string[] authors = {"Forever <forever@aroace.space>"};
	        // Translators: add your names and emails to this table, one per line as shown
	        string translators = _("translator-credits");
	        string[] artists = {"Forever <forever@aroace.space>", "Jakub Steiner <jimmac@gmail.com>"};
	        var win = new Adw.AboutWindow () {
	            // Translators: This is a noun and not a verb.
                application_name = _("Random"),
                application_icon = "page.codeberg.foreverxml.Random",
                version = "1.5",
                comments = _("Randomizing made easy") + ": " + _("A tool to pick a random number or list item. Pick what chore to do, a number between 1 and 100, whether or not to jump on your mom's bed, etc."),
                copyright = "Copyright © 2021-2022 Forever",
                license_type = License.AGPL_3_0,
                developer_name = "Forever",
                developers = authors,
                artists = artists,
                translator_credits = translators,
                website = "https://random.amongtech.cc",
                issue_url = "https://codeberg.org/foreverxml/random/issues",
                release_notes = "<p>" + _("Random recieves more translations and a migration to AdwAboutWindow in this quality-of-life release.") + "</p>"
            };
            win.add_link (_("Random on the Fediverse"), "https://fedi.aroace.space/@random");

            win.set_transient_for (this);
            win.show ();
        }

        private void shortcuts () {
            try {
                var ui_builder = new Gtk.Builder ();
                ui_builder.add_from_resource ("/page/codeberg/foreverxml/Random/shortcut.ui");
                var shortcuts_window = ui_builder.get_object ("shortcutting") as ShortcutsWindow;

                shortcuts_window.set_transient_for (this);
                shortcuts_window.show ();
            } catch (Error e) {
                critical ("An error occurred while loading shortcuts window: %s", e.message);
            }

        }

        private void quit () {
            this.close ();
            this.destroy ();
        }

        private void change () {
            if (stack1.get_visible_child () == rou.get_child ()) {
                stack1.set_visible_child (coinpage.get_child ());
            } else if (stack1.get_visible_child () == coinpage.get_child ()) {
                stack1.set_visible_child (numstack.get_child ());
            } else {
                stack1.set_visible_child (rou.get_child ());
            }
        }

        private void menuopener () {
            menus.popup ();
        }

        private void help () {
            show_uri (this, "https://foreverxml.codeberg.page/random/help", Gdk.CURRENT_TIME);
        }
	}
}
