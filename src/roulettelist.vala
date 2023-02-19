/* roulettelist.vala
 *
 * Copyright 2022-2023 Diego Iván <diegoivan.mae@gmail.com>
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

        private ActionEntry[] actions = {
            { "remove_all", remove_all_items },
            { "from-clipboard", get_items_from_clipboard }
        };

        construct {
            Action action = settings.create_action ("remove-drawn");

            var action_group = new SimpleActionGroup ();
            action_group.add_action_entries (actions, this);
            action_group.add_action (action);

            insert_action_group ("roulette", action_group);
        }

        [GtkCallback]
        public void add_new_item () {
            var n_row = new RouletteRow ();
            n_row.remove_request.connect (remove_row);
            listbox.append (n_row);

            n_row.opacity = 0;
            var target = new Adw.CallbackAnimationTarget ((v) => {
                n_row.opacity = v;
            });

            var animation = new Adw.TimedAnimation (n_row,
                0, 1, 200,
                target
            );

            animation.easing = EASE_IN_OUT_CUBIC;
            animation.play ();
            animation.done.connect (() => {
                n_row.text_entry.grab_focus ();
            });
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

            int selected_index = GLib.Random.int_range (0, items.length);

            if (settings.get_boolean ("remove-drawn"))
                listbox.remove (listbox.get_row_at_index (selected_index));

            return items [selected_index];
        }

        public void remove_all_items () {
            var target = new Adw.CallbackAnimationTarget ((v) => {
                listbox.opacity = v;
            });

            var out_animation = new Adw.TimedAnimation (listbox,
                0, 1, 200,
                target
            );
            out_animation.alternate = true;
            out_animation.reverse = true;
            out_animation.play ();

            out_animation.done.connect (() => {
                Gtk.ListBoxRow? current_row = listbox.get_row_at_index (0);
                while (current_row != null) {
                    listbox.remove (current_row);
                    current_row = listbox.get_row_at_index (0);
                }

                var animation2 = new Adw.TimedAnimation (listbox,
                    0, 1, 150,
                    target
                );
                animation2.play ();
            });
        }

        public void add_items_from_range (int start, int end) {
            for (int i = start; i <= end; i++) {
                var n_row = new RouletteRow () {
                    content = i.to_string ()
                };

                n_row.remove_request.connect (remove_row);
                listbox.append (n_row);
            }
        }

        private void add_items_from_array (string[] array) {
            foreach (var item in array) {
                var n_row = new RouletteRow () {
                    content = item
                };

                n_row.remove_request.connect (remove_row);
                listbox.append (n_row);
            }
        }

        private async void paste_from_clipboard () {
            var dialog = new Adw.MessageDialog ((Gtk.Window) root, _("Paste from clipboard"),
                                                _("Select a separator…"));

            dialog.add_response ("cancel", _("Cancel"));
            dialog.add_response ("add", _("Add"));

            dialog.close_response = "cancel";
            dialog.default_response = "cancel";

            var separator_entry = new Gtk.Entry ();
            dialog.extra_child = separator_entry;

            dialog.show ();

            string response = yield dialog.choose (null);
            if (response == "cancel" || separator_entry.text == "") {
                return;
            }

            try {
                unowned var clipboard = Gdk.Display.get_default ().get_clipboard ();
                string clipboard_text = yield clipboard.read_text_async (null);

                // Remove all elements
                Gtk.ListBoxRow? iter = listbox.get_row_at_index (0);
                while (iter != null) {
                    listbox.remove (iter);
                    iter = listbox.get_row_at_index (0);
                }

                string[] elements = clipboard_text.split (separator_entry.text);
                add_items_from_array (elements);
            }
            catch (Error e) {
                critical (e.message);
            }
        }

        private void get_items_from_clipboard () {
            paste_from_clipboard.begin ();
        }
    }
}
