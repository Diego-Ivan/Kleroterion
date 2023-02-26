/* Page.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

[GtkTemplate (ui = "/page/codeberg/foreverxml/Random/pages/page.ui")]
public abstract class Random.Page : Adw.Bin {
    public abstract string content { owned get; }
    public abstract string title { owned get; }
    public abstract void generate ();

    construct {
        ActionEntry[] actions = {
            { "generate", generate },
            { "copy", copy_to_clipboard },
        };
        var action_group = new SimpleActionGroup ();
        action_group.add_action_entries (actions, this);
        insert_action_group ("page", action_group);
    }

    public virtual void copy_to_clipboard () {
        message ("Copying..");
        unowned Gdk.Clipboard clipboard = Gdk.Display.get_default ().get_clipboard ();
        clipboard.set_text (content);
    }
}
