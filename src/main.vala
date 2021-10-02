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
namespace Random {
    public class Application : Adw.Application {
        public static Window win = null;

        public Application () {
            Object (
                flags: ApplicationFlags.FLAGS_NONE,
                application_id: "page.codeberg.foreverxml.Random"
            );
        }

        construct {
            // Init gettext
	        Intl.setlocale (LocaleCategory.ALL, "");
	        Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
	        Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
	        Intl.textdomain (GETTEXT_PACKAGE);
        }

        protected override void activate () {
            if (win != null) {
                win.present ();
                return;
            }
            win = new Random.Window (this);
        }

        public static int main (string[] args) {
            var app = new Random.Application ();
            return app.run (args);
        }
    }
}
