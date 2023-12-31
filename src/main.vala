/*
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
using GLib;
namespace Kleroterion {
    GLib.Settings settings;
    public class Application : Adw.Application {
        private Window main_window;

        public Application () {
            Object (
                flags: ApplicationFlags.FLAGS_NONE,
                application_id: "io.github.diegoivan.Kleroterion"
            );
            Intl.setlocale (LocaleCategory.ALL, "");
	        Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
	        Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
	        Intl.textdomain (GETTEXT_PACKAGE);
        }

        construct {
	        settings = new GLib.Settings ("io.github.diegoivan.Kleroterion");
        }

        protected override void activate () {
            if (main_window == null) {
                main_window = new Window (this);
            }
            main_window.present ();
        }

        protected override void shutdown () {
            settings.apply ();
            base.shutdown ();
        }

        public static int main (string[] args) {
            var app = new Kleroterion.Application ();
            return app.run (args);
        }
    }
}
