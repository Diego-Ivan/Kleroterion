/* window.vala
 *
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
        private Rand rand = new Rand ();
        private ShortcutsWindow shortcuts_window;
        private CssProvider css = new CssProvider ();


		public Window (Gtk.Application app) {
			Object (application: app);
		}

		construct {

		    string cssf = rand.int_range (1, 7).to_string ();
		    css.load_from_resource ("/page/codeberg/foreverxml/Random/" + cssf + ".css");
		    StyleContext.add_provider_for_display(Gdk.Display.get_default (), css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
		    genn.clicked.connect (() => {
	            int numb1 = int.parse (num1.get_text ());
	            int numb2 = int.parse (num2.get_text ()) + 1;
	            string txt = rand.int_range (numb1, numb2).to_string ();
	            endn.set_label (txt);
	        });
	        genc.clicked.connect (() => {
	            string tex = ctxt.get_text ();
	            if (cphr.get_text () == "" | cphr.get_text () == null) {
	                cphr.set_text ("/");
	                debug ("Setting seperator to /; no seperator found.");
	            }
	            string[] texa = tex.split (cphr.get_text ());
	            string txt = texa[rand.int_range (0, texa.length)];
	            if (tex == "Hey adora") {
	                txt = "Catra!? What are you doing here?";
	            }
                endc.set_label (txt);
	        });
	        cf.clicked.connect (() => {
	            int r = rand.int_range (0, 2);
	            string t = "You got heads!";
	            if (r == 1) {
	                t = "You got tails!";
	            }
	            cl.set_label (t);
	        });
	    }

	    public void about () {
	        string[] authors = {"Forever XML <foreverxml@tuta.io>"};
	        string translators = """Forever XML <foreverxml@tuta.io>"""; //translators: add your names and emails to this table, one per line
	        show_about_dialog (this,
	            // Translators: This is a noun and not a verb.
                program_name: "Random",
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "0.8.devel",
                comments: "Is it brown, green, blue...",
                copyright: "Copyright © 2021 Forever XML",
                license_type: License.AGPL_3_0,
                authors: authors,
                translator_credits: translators,
                website: "https://codeberg.org/foreverxml/random",
                website_label: "Repository");
        }

        public void number () {
            if (stack1.get_visible_child () != numstack.get_child ()) {
                stack1.set_visible_child (numstack.get_child ()); // TODO bigger menu btn
            } else {
                int numb1 = int.parse (num1.get_text ());
	            int numb2 = int.parse (num2.get_text ()) + 1;
	            string list = num1.get_text ();
	            for (int i = numb1 + 1; i < numb2; i++) {
                    list = list + "/" + i.to_string ();
	            }
	            ctxt.set_text (list);
	            cphr.set_text ("/");
                stack1.set_visible_child (rou.get_child ());
            }
        }

        public void remove () {
            if (stack1.get_visible_child () != rou.get_child ()) {
                stack1.set_visible_child (rou.get_child ());
            } else {
                genc.activate ();
                string tex = ctxt.get_text ();
                if (tex == "") { return; }
                string split = cphr.get_text ();
	            string end = endc.get_label ();
                string[] texa = tex.split (split);
                string enda;
                for (int i = 0; i < texa.length; i++) {
                    if (texa[i] == end) {
                        for (int k = i; k < texa.length - 1; k++) {
                            texa[k] = texa[k+1];
                            texa[k+1] = null;
                        }
                        break;
                    }
                }
                if (texa.length == 1) {
                    texa[0] = null;
                    ctxt.set_text ("");
                    return;
                }
                texa.resize (texa.length-1);
                enda = texa[0];
                for (int j = 1; j < texa.length; j++) {
                    enda = enda + split + texa[j];
                }
                ctxt.set_text (enda);
            }
        }

        public void generate () {
            if (stack1.get_visible_child () == rou.get_child ()) {
                genc.activate ();
            } else if (stack1.get_visible_child () == numstack.get_child ()) {
                genn.activate ();
            } else {
                cf.activate ();
            }
        }

        public void shortcuts () {
            Builder builder = new Builder ();
            if (shortcuts_window == null) {
                try {
                    builder.add_from_resource ("/page/codeberg/foreverxml/Random/shortcut.ui");
                } catch (Error e) {
                    error ("Error loading shortcuts window UI: %s", e.message);
                }
            }

            shortcuts_window = builder.get_object ("shortcutting") as ShortcutsWindow;
            shortcuts_window.close.connect ((event) => {
                shortcuts_window.destroy ();
                shortcuts_window = null;
            });

            if (this != shortcuts_window.get_transient_for ()) {
                shortcuts_window.set_transient_for (this);
            }
            shortcuts_window.present ();

        }

        public void quit () {
            this.close ();
            this.destroy ();
        }

        public void change () {
            if (stack1.get_visible_child () == rou.get_child ()) {
                stack1.set_visible_child (coinpage.get_child ());
            } else if (stack1.get_visible_child () == coinpage.get_child ()) {
                stack1.set_visible_child (numstack.get_child ());
            } else {
                stack1.set_visible_child (rou.get_child ());
            }
        }

        public void menuopener () {
            menus.popup ();
        }
	}
}
