/* RoulettePage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
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

[GtkTemplate (ui = "/io/github/diegoivan/Kleroterion/pages/roulettepage.ui")]
public class Kleroterion.RoulettePage : Page {
    [GtkChild]
    private unowned Gtk.Label picked_label;
    [GtkChild]
    private unowned RouletteList roulette_list;

    public override string content {
        owned get {
            return picked_label.label;
        }
    }

    public override void generate () {
        string? picked_item = roulette_list.pick_random ();
        if (picked_item == null) {
            return;
        }

        var target = new Adw.PropertyAnimationTarget (picked_label, "opacity");
        var animation = new Adw.TimedAnimation (picked_label, 1, 0, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        var reverse_animation = new Adw.TimedAnimation (picked_label, 0, 1, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        animation.play ();
        animation.done.connect (() => {
            picked_label.label = picked_item;
            reverse_animation.play ();
        });
    }
}
