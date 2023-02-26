/* NumberPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/pages/numberpage.ui")]
public class Random.NumberPage : Page {
    [GtkChild]
    private unowned NumberRow min_row;
    [GtkChild]
    private unowned NumberRow max_row;
    [GtkChild]
    private unowned Gtk.Label number_label;

    public signal void send_to_roulette (int min, int max);

    public override string content {
        owned get {
            return number_label.label;
        }
    }

    public override void generate () {
        int lower = (int) min_row.value;
        int upper = (int) max_row.value;

        if (upper < lower) {
            lower = (int) max_row.value;
            upper = (int) min_row.value;
        }

        if (upper == lower) {
            upper++;
        }

        int generated_number = GLib.Random.int_range (lower, upper + 1);
        display_number (generated_number);
    }

    private void display_number (int number) {
        var target = new Adw.PropertyAnimationTarget (number_label, "opacity");
        var animation = new Adw.TimedAnimation (number_label, 1, 0, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        var reverse_animation = new Adw.TimedAnimation (number_label, 0, 1, 150, target) {
            easing = EASE_IN_OUT_CUBIC
        };

        animation.play ();
        animation.done.connect (() => {
            number_label.label = number.to_string ();
            reverse_animation.play ();
        });
    }
}

public class Random.NumberRow : Adw.ActionRow {
    private Gtk.SpinButton spin_button = new Gtk.SpinButton.with_range (-2000000, 2000000, 1);

    public double @value {
        get {
            return spin_button.value;
        }
        set {
            spin_button.value = value;
        }
    }

    construct {
        spin_button.valign = CENTER;
        add_suffix (spin_button);
    }

    public override bool grab_focus () {
        return spin_button.grab_focus ();
    }
}
