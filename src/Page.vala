/* Page.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

public interface Random.Page : Gtk.Widget {
    public abstract string content { owned get; }
    public abstract string title { owned get; }
    public abstract string name { owned get; }
    public abstract void generate ();

    public virtual void copy_to_clipboard () {
        unowned Gdk.Clipboard clipboard = get_clipboard ();
        clipboard.set_text (content);
    }
}
