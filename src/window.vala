/* window.vala
 *
 * Copyright 2021 Forever XML
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
		[GtkChild] private unowned Label endn;
		[GtkChild] private unowned Entry num1;
		[GtkChild] private unowned Button genn;
		[GtkChild] private unowned Entry num2;
        [GtkChild] private unowned Entry cphr;
        [GtkChild] private unowned Entry ctxt;
        [GtkChild] private unowned Button genc;
        [GtkChild] private unowned Label endc;
        [GtkChild] private unowned Button cf;
        [GtkChild] private unowned Label cl;
        [GtkChild] private unowned Adw.ViewStackPage rou;
        [GtkChild] private unowned Adw.ViewStackPage numstack;
        [GtkChild] private unowned Adw.ViewStackPage coinpage;
        [GtkChild] private unowned Adw.ViewStack stack1;
        [GtkChild] private unowned MenuButton menus;
        private Random.Func Randomize = new Random.Func ();
        private ActionEntry[] actions;
        private SimpleActionGroup actionc = new SimpleActionGroup ();
        public Gtk.Application app { get; construct; }


		public Window (Gtk.Application app) {
			Object (
			    application: app,
			    app: app
			);
		}

		construct {
            // actions
		    actions = {
                {"about", about},
                {"number", number},
                {"remove", remove},
                {"generate", generate},
                {"shortcuts", shortcuts},
                {"quit", quit},
                {"change", change},
                {"menuopener", menuopener},
                {"help", help},
                {"copy", copy}
            };
            actionc.add_action_entries (actions, this);
            insert_action_group ("app", actionc);

            app.set_accels_for_action ("app.number", {"<Primary><Shift>r"});
            app.set_accels_for_action ("app.remove", {"<Primary>d"});
            app.set_accels_for_action ("app.generate", {"<Primary>g"});
            app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
            app.set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
            app.set_accels_for_action ("app.change", {"<Primary>Tab"});
            app.set_accels_for_action ("app.menuopener", {"F10"});
            app.set_accels_for_action ("app.copy", {"<Primary><Shift>c"});

            // number
		    genn.clicked.connect (() => {
	            string txt = Randomize.Number (num1.get_text (), num2.get_text (), false);
	            endn.set_label (txt);
	        });

	        // roulette
	        genc.clicked.connect (() => {
	            if (txt == "Hey adora") {
	                txt = "Catra!? What are you doing here?";
	            }
	            string txt = Randomize.Roulette (ctxt.get_text (), cphr.get_text ());
                endc.set_label (txt);
	        });

	        // coinflip
	        cf.clicked.connect (() => {
	            cl.set_label (Randomize.Coin (_("You got heads!"), _("You got tails!")));
	        });
	        this.present ();
	    }

	    private void about () {
	        string[] authors = {"Forever XML <foreverxml@tuta.io>"};
	        // Translators: add your names and emails to this table, one per line as shown
	        string translators = """Forever XML <foreverxml@tuta.io>
	                                Teackot <k.qovekt@gmail.com>
	                                Diego Iván <diegoivan.mae@gmail.com>""";
	        show_about_dialog (this,
	            // Translators: This is a noun and not a verb.
                program_name: _("Random"),
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "1.1",
                comments: "Random shmandom...",
                copyright: "Copyright © 2021 Forever XML",
                license_type: License.AGPL_3_0,
                authors: authors,
                translator_credits: translators,
                website: "https://codeberg.org/foreverxml/random",
                website_label: _("Repository"));
        }

        private void number () {
            if (stack1.get_visible_child () != numstack.get_child ()) {
                stack1.set_visible_child (numstack.get_child ()); // TODO bigger menu btn
            } else {
	            string list = Randomize.NumberRoulette (int.parse (num1.get_text ()), int.parse (num2.get_text ()));
	            ctxt.set_text (list);
	            cphr.set_text ("/");
                stack1.set_visible_child (rou.get_child ());
            }
        }

        private void remove () {
            if (stack1.get_visible_child () != rou.get_child ()) {
                stack1.set_visible_child (rou.get_child ());
            } else {
                if (endc.get_text () == _("You haven't rolled yet!")) {
                    genc.activate ();
                } else {
	                string[] enda = Randomize.DeleteRoulette (ctxt.get_text (), cphr.get_text ());
                    endc.set_label (enda[0])
                    ctxt.set_text (enda[1]);
                }
            }
        }

        private void generate () {
            if (stack1.get_visible_child () == rou.get_child ()) {
                genc.activate ();
            } else if (stack1.get_visible_child () == numstack.get_child ()) {
                genn.activate ();
            } else {
                cf.activate ();
            }
        }

        private void shortcuts () {
            try {
                var ui_builder = new Gtk.Builder ();
                ui_builder.add_from_resource ("/page/codeberg/foreverxml/Random/shortcut.ui");
                var shortcuts_window = ui_builder.get_object ("shortcutting") as ShortcutsWindow;

                shortcuts_window.set_transient_for (this);
                shortcuts_window.show ();
            } catch (Error e) {
                critical ("An error occured while loading shortcuts window: %s", e.message);
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

        private void copy () {
            if (num1.has_focus ||
                num2.has_focus ||
                cphr.has_focus ||
                ctxt.has_focus ) {
                    return;
            }
            Gdk.Clipboard clip = get_clipboard ();
            if (stack1.get_visible_child () == rou.get_child ()) {
                clip.set_text (endc.get_label ());
            } else if (stack1.get_visible_child () == coinpage.get_child ()) {
                clip.set_text (cl.get_label ());
            } else {
                clip.set_text (endn.get_label ());
            }
        }

        private void help () {
            show_uri (this, "https://codeberg.org/foreverxml/random/src/branch/main/help/README.md", Gdk.CURRENT_TIME);
        }
	}
}
