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
	public class Window : Gtk.ApplicationWindow {
	    // todo: fix error here
		[GtkChild]
		Gtk.Label endn;
		[GtkChild]
		Gtk.Label endt;
		[GtkChild]
		Gtk.Entry num1;
		[GtkChild]
		Gtk.Entry num2;
		[GtkChild]
		Gtk.Entry text;
		[GtkChild]
        Gtk.Button genn;
        [GtkChild]
        Gtk.Button gent;

		public Window (Gtk.Application app) {
			Object (application: app);
		}

		construct {
		    GLib.Rand rand = new GLib.Rand();
		    genn.clicked.connect (() => {
	            int numb1 = int.parse(num1.get_text());
	            int numb2 = int.parse(num2.get_text());
	            string txt = rand.int_range(numb1, numb2).to_string();
	            endn.set_label(txt);
	        });
	        gent.clicked.connect (() => {
                string tex = text.get_text();
                string[] texa = tex.split("/");
                string txt = texa[rand.int_range(0, texa.length)];
                endt.set_label(txt);
	        });
	    }

	    public void about () {
	        string[] authors = {"Forever XML <foreverxml@tuta.io>"};
	        Gtk.show_about_dialog (this,
                program_name: "Random",
                logo_icon_name: "page.codeberg.foreverxml.Random",
                version: "0.1",
                comments: "Magic 8 ball, will I be happy today?",
                copyright: "Copyright © 2021 Forever XML",
                license_type: Gtk.License.AGPL_3_0,
                authors: authors,
                website: "https://codeberg.org/foreverxml/random",
                website_label: "Repository");
        }
	}
}
