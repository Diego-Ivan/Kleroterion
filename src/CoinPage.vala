/* CoinPage.vala
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

[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/pages/coinpage.ui")]
public class Random.CoinPage : Page {
    [GtkChild]
    private unowned Gtk.Label flipped_label;

    public override string content {
        owned get {
            return flipped_label.label;
        }
    }

    public override void generate () {
        int flipped = GLib.Random.int_range (0, 2);
        string result = flipped == 1 ? _("Heads") : _("Tails");

        reveal_result (result);
    }

    private void reveal_result (string result) {
        var target = new Adw.PropertyAnimationTarget (flipped_label, "opacity");
        var animation = new Adw.TimedAnimation (flipped_label, 1, 0, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        var reverse_animation = new Adw.TimedAnimation (flipped_label, 0, 1, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        animation.play ();
        animation.done.connect (() => {
            flipped_label.label = result;
            reverse_animation.play ();
        });
    }
}
