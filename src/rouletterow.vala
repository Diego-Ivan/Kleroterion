/* rouletterow.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 * Copyright 2021-2022 Forever XML
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

namespace Random {
    public class RouletteRow : Adw.PreferencesRow {
        public Gtk.Entry text_entry { get; private set; }
        private Gtk.Button remove_button;
        public string content {
            get {
                return text_entry.text;
            }
            set {
                text_entry.text = value;
            }
        }

        public signal void remove_request (RouletteRow r);

        construct {
            activatable = false;
            var box = new Gtk.Box (HORIZONTAL, 12) {
                hexpand = true,
                margin_top = 12,
                margin_bottom = 12,
            };

            text_entry = new Gtk.Entry () {
                hexpand = true,
                margin_start = 12,
                focusable = true
            };
            box.append (text_entry);

            remove_button = new Gtk.Button () {
                icon_name = "user-trash-symbolic",
                vexpand = false,
                valign = CENTER,
                halign = END,
                margin_start = 6
            };
            remove_button.add_css_class ("flat");
            remove_button.clicked.connect (() => {
                remove_request (this);
            });

            box.append (remove_button);

            child = box;
        }
    }
}
