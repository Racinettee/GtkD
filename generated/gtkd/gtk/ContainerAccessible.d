/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version, with
 * some exceptions, please read the COPYING file.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

// generated automatically - do not change
// find conversion definition on APILookup.txt
// implement new conversion functionalities on the wrap.utils pakage


module gtk.ContainerAccessible;

private import gtk.WidgetAccessible;
private import gtk.c.functions;
public  import gtk.c.types;
public  import gtkc.gtktypes;


/** */
public class ContainerAccessible : WidgetAccessible
{
	/** the main Gtk struct */
	protected GtkContainerAccessible* gtkContainerAccessible;

	/** Get the main Gtk struct */
	public GtkContainerAccessible* getContainerAccessibleStruct(bool transferOwnership = false)
	{
		if (transferOwnership)
			ownedRef = false;
		return gtkContainerAccessible;
	}

	/** the main Gtk struct as a void* */
	protected override void* getStruct()
	{
		return cast(void*)gtkContainerAccessible;
	}

	protected override void setStruct(GObject* obj)
	{
		gtkContainerAccessible = cast(GtkContainerAccessible*)obj;
		super.setStruct(obj);
	}

	/**
	 * Sets our main struct and passes it to the parent class.
	 */
	public this (GtkContainerAccessible* gtkContainerAccessible, bool ownedRef = false)
	{
		this.gtkContainerAccessible = gtkContainerAccessible;
		super(cast(GtkWidgetAccessible*)gtkContainerAccessible, ownedRef);
	}


	/** */
	public static GType getType()
	{
		return gtk_container_accessible_get_type();
	}
}
