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

namespace Random {
	[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/window.ui")]
	public class Window : Hdy.ApplicationWindow {
	    // TODO: fix error here
		[GtkChild]
		Gtk.Label endn;
		[GtkChild]
		Gtk.Entry num1;
		[GtkChild]
		Gtk.Button genn;
		[GtkChild]
		Gtk.Entry num2;
        [GtkChild]
        Gtk.Entry cphr;
        [GtkChild]
        Gtk.Entry ctxt;
        [GtkChild]
        Gtk.Button genc;
        [GtkChild]
        Gtk.Label endc;
        [GtkChild]
        Gtk.Button cf;
        [GtkChild]
        Gtk.Label cl;


		public Window (Gtk.Application app) {
			Object (application: app);
		}

		construct {
		    GLib.Rand rand = new GLib.Rand ();
		    genn.clicked.connect (() => {
	            int numb1 = int.parse (num1.get_text ());
	            int numb2 = int.parse (num2.get_text ()) + 1;
	            string txt = rand.int_range (numb1, numb2).to_string ();
	            endn.set_label (txt);
	        });
	        genc.clicked.connect (() => {
	            string tex = ctxt.get_text ();
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
	        Gtk.show_about_dialog (this,
                program_name: "Random",
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "0.4.devel",
                comments: "Flippy flip.",
                copyright: "Copyright © 2021 Forever XML",
                license_type: Gtk.License.AGPL_3_0,
                authors: authors,
                website: "https://codeberg.org/foreverxml/random",
                website_label: "Repository");
        }
	}
}
