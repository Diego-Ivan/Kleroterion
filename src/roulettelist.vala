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

namespace Kleroterion {
    [GtkTemplate (ui = "/io/github/diegoivan/Kleroterion/roulettelist.ui")]
    public class RouletteList : Adw.PreferencesGroup {
        [GtkChild]
        private unowned Gtk.ListBox listbox;
        [GtkChild]
        private unowned Gtk.Revealer listbox_revealer;

        private ListStore items = new ListStore (typeof (RouletteItem));

        private ActionEntry[] actions = {
            { "remove_all", remove_all_items },
            { "from-clipboard", get_items_from_clipboard },
            { "remove-drawn", remove_drawn_items },
        };

        construct {
            Action action = settings.create_action ("remove-drawn");

            var action_group = new SimpleActionGroup ();
            action_group.add_action_entries (actions, this);
            action_group.add_action (action);

            insert_action_group ("roulette", action_group);

            items.items_changed.connect (on_items_changed);

            listbox.bind_model (items, on_item_bound);
        }

        private Gtk.Widget on_item_bound (Object item) {
            var roulette_row = new RouletteRow ((RouletteItem) item);
            roulette_row.delete_request.connect (on_item_removed);

            Timeout.add (50, () => {
                roulette_row.grab_focus ();
                return Source.REMOVE;
            });

            return roulette_row;
        }

        private void on_item_removed (RouletteRow row) {
            remove_item (row.item);
        }

        private void remove_item (RouletteItem item) {
            uint position;
            bool found = items.find (item, out position);

            if (!found) {
                return;
            }
            items.remove (position);
        }

        private void on_items_changed () {
            if (items.get_n_items () == 0) {
                listbox_revealer.reveal_child = false;
                return;
            }
            if (listbox_revealer.child_revealed) {
                return;
            }
            listbox_revealer.reveal_child = true;
        }

        [GtkCallback]
        public void add_new_item () {
            items.append (new RouletteItem ());
        }

        public string? pick_random ()
            requires (items.get_n_items () > 0)
        {
            RouletteItem[] pickable_items = {};

            for (int i = 0; i < items.get_n_items (); i++) {
                var item = (RouletteItem) items.get_object (i);
                if (item.empty || item.picked) {
                    continue;
                }
                pickable_items += item;
            }

            if (pickable_items.length < 1) {
                return null;
            }

            int selected_index = GLib.Random.int_range (0, pickable_items.length);
            RouletteItem selected_item = pickable_items[selected_index];

            if (settings.get_boolean ("remove-drawn")) {
                selected_item.picked = true;
            }

            return selected_item.item;
        }

        public void remove_all_items () {
            items.remove_all ();
        }

        private void remove_drawn_items () {
            for (int i = 0; i < items.get_n_items (); i++) {
                var item = (RouletteItem) items.get_object (i);
                if (item.picked) {
                    remove_item (item);
                }
            }
        }

        public void add_items_from_range (int start, int end) {
            for (int i = start; i <= end; i++) {
                var new_item = new RouletteItem () {
                    item = i.to_string ()
                };
                items.append (new_item);
            }
        }

        private void add_items_from_array (string[] array) {
            foreach (var item in array) {
                var new_item = new RouletteItem () {
                    item = item
                };
                items.append (new_item);
            }
        }

        private void get_items_from_clipboard () {
            paste_from_clipboard.begin ();
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

                remove_all_items ();

                string[] elements = clipboard_text.split (separator_entry.text);
                add_items_from_array (elements);
            }
            catch (Error e) {
                critical (e.message);
            }
        }
    }

    public class RouletteItem : Object {
        public string item { get; set; default = ""; }
        public bool picked { get; set; default = false; }
        public bool empty {
            get {
                return item == "";
            }
        }

        ~RouletteItem () {
            message ("Destructing");
        }
    }
}
