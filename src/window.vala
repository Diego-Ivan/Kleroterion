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
		[GtkChild] private unowned Label endn;
		[GtkChild] private unowned SpinButton num1;
		[GtkChild] private unowned Button genn;
		[GtkChild] private unowned SpinButton num2;
        [GtkChild] private unowned Entry ctxt;
        [GtkChild] private unowned Button genc;
        [GtkChild] private unowned Button dels;
        [GtkChild] private unowned Button numr;
        [GtkChild] private unowned Label endc;
        [GtkChild] private unowned Button cf;
        [GtkChild] private unowned Label cl;
        [GtkChild] private unowned Adw.ViewStackPage rou;
        [GtkChild] private unowned Adw.ViewStackPage numstack;
        [GtkChild] private unowned Adw.ViewStackPage coinpage;
        [GtkChild] private unowned Adw.ViewStack stack1;
        [GtkChild] private unowned MenuButton menus;
        [GtkChild] private unowned Revealer numrev;
        [GtkChild] private unowned Revealer rourev;
        [GtkChild] private unowned Revealer coinrev;
        [GtkChild] private unowned Adw.ViewSwitcherTitle title;
        [GtkChild] private unowned Adw.ViewSwitcherBar bar;
        [GtkChild] private unowned ListBox robox;
        private Random.Func Randomize = new Random.Func ();
        // Translators: If the language is in Latin, leave these be. If it is not, insert names here, and don't translate the strings.
        private StringList rlet = new StringList ({_("Layla"), _("Rose"), _("Cleveland"), _("Lampy")});
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

            app.set_accels_for_action ("app.number", {"<Primary><Shift>c"});
            app.set_accels_for_action ("app.remove", {"<Primary><Shift>g"});
            app.set_accels_for_action ("app.generate", {"<Primary>g"});
            app.set_accels_for_action ("app.shortcuts", {"<Primary>question"});
            app.set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
            app.set_accels_for_action ("app.change", {"<Primary>Tab"});
            app.set_accels_for_action ("app.menuopener", {"F10"});
            app.set_accels_for_action ("app.copy", {"<Primary>c"});

            // number
		    genn.clicked.connect (() => {
		        numrev.set_reveal_child (false);
		        Timeout.add (250, () => {
	            string txt = Randomize.Number (num1.get_value_as_int (), num2.get_value_as_int ()).to_string ();
	            endn.set_label (txt);
	            numrev.set_reveal_child (true);
	            });
	        });

	        stack1.notify["visible-child"].connect (() => {
	            if (stack1.get_visible_child () == rou.get_child ()) {
                    this.set_default_widget (genc);
                } else if (stack1.get_visible_child () == coinpage.get_child ()) {
                    this.set_default_widget (cf);
                } else {
                    this.set_default_widget (genn);
                }
	        });
	        this.set_default_widget (genn);

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
	            string txt = Randomize.Roulette (ctxt.get_text (), "/");
	            if (txt == "Hey adora") {
	                txt = "Catra!? What are you doing here?";
	            }
                endc.set_label (txt);
                rourev.set_reveal_child (true);
                });
	        });

	        dels.clicked.connect (() => {
                string[] enda = Randomize.DeleteRoulette (ctxt.get_text (), "/");
                endc.set_label (enda[0]);
                ctxt.set_text (enda[1]);
                refactor ();
            });

            numr.clicked.connect (() => {
	            string list = Randomize.NumberRoulette (num1.get_value_as_int (), num2.get_value_as_int ());
	            ctxt.set_text (list);
                stack1.set_visible_child (rou.get_child ());
                refactor ();
            });

	        // coinflip
	        cf.clicked.connect (() => {
	            coinrev.set_reveal_child (false);
	            Timeout.add(250, () => {
	            string cnr = Randomize.Coin (_("Heads"), _("Tails"));
	            cl.set_label (cnr);
	            coinrev.set_reveal_child (true);
	            });
	        });

	        ctxt.set_text ("Layla/Rose/Cleveland/Lampy");
	        refactor ();

	        this.present ();
	        this.set_default_widget (genn);

	        string txt = Randomize.Number (1, 10).to_string ();
	        endn.set_label (txt);
	    }

	    public void refactor () throws Error {
	        int i = 0;
	        try {
	            ListBoxRow? remover = null;
                while (robox.get_row_at_index (i) != null) {
                    remover = robox.get_row_at_index (i);
                    robox.remove (remover);
                    remover.unrealize ();
                    i = i + 1;
                }
                string load = ctxt.get_text ();
                if (load == "") { return; }
                string[] loader = load.split ("/");
                for (int j = 0; j < loader.length; j++) {
                    addrow (loader[j]);
                }
            } catch (Error e) {
                critical ("Whoops! Something happened. Here's what happened: %s", e.message);
            }
	    }

	    public void addrow (string titled) {
	        Adw.ActionRow newrow = new Adw.ActionRow ();
	        newrow.set_title (titled);
	        Button button = new Button ();
	        button.set_hexpand (false);
	        button.clicked.connect (() => {
	            string edit = ctxt.get_text ();
	            string[] texa = edit.split ("/");
	            // roulette string reassembly
	            for (int t = 0; t < texa.length; t++) {
                    if (texa[t] == titled) {
                            for (int k = t; k < texa.length - 1; k++) {
                            texa[k] = texa[k+1];
                            texa[k+1] = null;
                        }
                        break;
                    }
                }
                if (texa.length == 1) {
                    texa[0] = null;
                    ctxt.set_text ("");
                    refactor ();
                    return;
                }
                texa.resize (texa.length-1);
                edit = texa[0];
                for (int j = 1; j < texa.length; j++) {
                    edit = edit + "/" + texa[j];
                }
                ctxt.set_text (edit);
                refactor ();
                return;
	        });
	        Image del = new Image ();
	        del.set_from_icon_name ("user-trash-symbolic");
	        button.set_child (del);
	        newrow.set_child (button);
	        robox.append (newrow);
	    }

	    private void about () {
	        string[] authors = {"Forever XML <foreverxml@tuta.io>"};
	        // Translators: add your names and emails to this table, one per line as shown
	        string translators = _("translator-credits");
	        string[] artists = {"Forever XML <foreverxml@tuta.io>", "Jakub Steiner <jimmac@gmail.com>"};
	        show_about_dialog (this,
	            // Translators: This is a noun and not a verb.
                program_name: _("Random"),
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "1.4",
                comments: _("Randomizing made easy"),
                copyright: "Copyright © 2021 Forever XML",
                license_type: License.AGPL_3_0,
                authors: authors,
                artists: artists,
                translator_credits: translators,
                website: "https://codeberg.org/foreverxml/random",
                website_label: _("Repository"));
        }

        private void number () {
            if (stack1.get_visible_child () != numstack.get_child ()) {
                stack1.set_visible_child (numstack.get_child ()); // TODO bigger menu btn
            } else {
	            string list = Randomize.NumberRoulette (num1.get_value_as_int (), num2.get_value_as_int ());
	            ctxt.set_text (list);
                stack1.set_visible_child (rou.get_child ());
                refactor ();
            }
        }

        private void remove () {
            if (stack1.get_visible_child () != rou.get_child ()) {
                stack1.set_visible_child (rou.get_child ());
            } else {
                string[] enda = Randomize.DeleteRoulette (ctxt.get_text (), "/");
                endc.set_label (enda[0]);
                ctxt.set_text (enda[1]);
                refactor ();
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

        private void copy () {
            if (num1.has_focus ||
                num2.has_focus ||
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
            show_uri (this, "https://foreverxml.codeberg.page/random/help", Gdk.CURRENT_TIME);
        }
	}
}
