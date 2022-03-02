/* roulettelist.vala
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
    [GtkTemplate (ui = "/page/codeberg/foreverxml/Random/roulettelist.ui")]
    public class RouletteList : Adw.PreferencesGroup {
        [GtkChild] private unowned Gtk.ListBox listbox;

        private const ActionEntry[] actions = {
            { "remove_all", remove_all_items }
        };

        construct {
            var action_group = new SimpleActionGroup ();
            action_group.add_action_entries (actions, this);

            insert_action_group ("roulette", action_group);
        }

        [GtkCallback]
        public void add_new_item () {
            var n_row = new RouletteRow ();
            n_row.remove_request.connect (remove_row);
            listbox.append (n_row);

            n_row.text_entry.grab_focus ();
        }

        private void remove_row (RouletteRow r) {
            listbox.remove (r);
        }

        public string pick_random () {
            string[] items = {};
            int i = 0;
            Gtk.ListBoxRow? current_row = listbox.get_row_at_index (i);

            while (current_row != null) {
                var r = current_row as RouletteRow;
                if (r.content == "") {
                    warning ("Item at %i is empty", i);
                }
                else {
                    items = items + r.content;
                }

                i++;
                current_row = listbox.get_row_at_index (i);
            }

            return items [GLib.Random.int_range (0, items.length)];
        }

        public void remove_all_items () {
            Gtk.ListBoxRow? current_row = listbox.get_row_at_index (0);

            while (current_row != null) {
                listbox.remove (current_row);
                current_row = listbox.get_row_at_index (0);
            }
        }

        private void get_items_from_clipboard () {
        }
    }
}
