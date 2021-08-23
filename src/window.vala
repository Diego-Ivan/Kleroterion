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
namespace Random {
	[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/window.ui")]
	public class Window : Adw.ApplicationWindow {
	    // TODO: fix error here
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


		public Window (Gtk.Application app) {
			Object (application: app);
		}

		construct {
		    try {
		    GLib.Rand rand = new GLib.Rand ();
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
	        } catch (Error e) {
	            print (e.message);
	        }
	    }

	    public void about () {
	        string[] authors = {"Forever XML <foreverxml@tuta.io>"};
	        Gtk.show_about_dialog (this,
                program_name: "Random",
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "0.5",
                comments: "Smoooth.",
                copyright: "Copyright © 2021 Forever XML",
                license_type: Gtk.License.AGPL_3_0,
                authors: authors,
                website: "https://codeberg.org/foreverxml/random",
                website_label: "Repository");
        }

        public void toggle () {
            try {
            GLib.Settings settings = new GLib.Settings ("page.codeberg.foreverxml.Random");
            bool dark = settings.get_boolean ("dark");
            if (!dark) {
                settings.set_boolean ("dark", false);
            } else {
                settings.set_boolean ("dark", true);
            }
            } catch (Error e) {
                print (e.message);
            }
        }
	}
}
