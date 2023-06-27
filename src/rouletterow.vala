/* rouletterow.vala
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

[GtkTemplate (ui = "/io/github/diegoivan/Kleroterion/ui/roulette-row.ui")]
public class Kleroterion.RouletteRow : Adw.EntryRow {
    private unowned RouletteItem _item;
    public unowned RouletteItem item {
        get {
            return _item;
        }
        construct {
            _item = value;
            item.bind_property ("item", this, "text", SYNC_CREATE | BIDIRECTIONAL);
            item.bind_property ("picked", this, "sensitive", SYNC_CREATE | INVERT_BOOLEAN);
        }
    }
    public signal void delete_request ();

    public RouletteRow (RouletteItem item) {
        Object (item: item);
    }

    [GtkCallback]
    private void on_delete_button_clicked () {
        delete_request ();
    }
}
