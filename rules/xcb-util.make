# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XCB_UTIL) += xcb-util

#
# Paths and names
#
XCB_UTIL_VERSION	:= 0.3.6
XCB_UTIL		:= xcb-util-$(XCB_UTIL_VERSION)
XCB_UTIL_SUFFIX		:= tar.bz2
XCB_UTIL_URL		:= http://xcb.freedesktop.org/dist/$(XCB_UTIL).$(XCB_UTIL_SUFFIX)
XCB_UTIL_SOURCE		:= $(SRCDIR)/$(XCB_UTIL).$(XCB_UTIL_SUFFIX)
XCB_UTIL_DIR		:= $(BUILDDIR)/$(XCB_UTIL)
XCB_UTIL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XCB_UTIL_SOURCE):
	@$(call targetinfo)
	@$(call get, XCB_UTIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XCB_UTIL_PATH		:= PATH=$(CROSS_PATH)
XCB_UTIL_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
XCB_UTIL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-util.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xcb-util)
	@$(call install_fixup, xcb-util,PRIORITY,optional)
	@$(call install_fixup, xcb-util,SECTION,base)
	@$(call install_fixup, xcb-util,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, xcb-util,DESCRIPTION,missing)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-atom.so.1.0.0)
	@$(call install_link, xcb-util, libxcb-atom.so.1.0.0, /usr/lib/libxcb-atom.so.1)
	@$(call install_link, xcb-util, libxcb-atom.so.1.0.0, /usr/lib/libxcb-atom.so)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-keysyms.so.1.0.0)
	@$(call install_link, xcb-util, libxcb-keysyms.so.1.0.0, /usr/lib/libxcb-keysyms.so.1)
	@$(call install_link, xcb-util, libxcb-keysyms.so.1.0.0, /usr/lib/libxcb-keysyms.so)	

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-aux.so.0.0.0)
	@$(call install_link, xcb-util,	libxcb-aux.so.0.0.0, /usr/lib/libxcb-aux.so.0)
	@$(call install_link, xcb-util, libxcb-aux.so.0.0.0, /usr/lib/libxcb-aux.so)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-property.so.1.0.0)
	@$(call install_link, xcb-util,	libxcb-property.so.1.0.0, /usr/lib/libxcb-property.so.1)
	@$(call install_link, xcb-util, libxcb-property.so.1.0.0, /usr/lib/libxcb-property.so)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-event.so.1.0.0)
	@$(call install_link, xcb-util,	libxcb-event.so.1.0.0, /usr/lib/libxcb-event.so.1)
	@$(call install_link, xcb-util, libxcb-event.so.1.0.0, /usr/lib/libxcb-event.so)
	
	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-render-util.so.0.0.0)
	@$(call install_link, xcb-util,	libxcb-render-util.so.0.0.0, /usr/lib/libxcb-render-util.so.0)
	@$(call install_link, xcb-util, libxcb-render-util.so.0.0.0, /usr/lib/libxcb-render-util.so)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-icccm.so.1.0.0)
	@$(call install_link, xcb-util, libxcb-icccm.so.1.0.0, /usr/lib/libxcb-icccm.so.1)
	@$(call install_link, xcb-util, libxcb-icccm.so.1.0.0, /usr/lib/libxcb-icccm.so)

	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-reply.so.1.0.0)
	@$(call install_link, xcb-util, libxcb-reply.so.1.0.0, /usr/lib/libxcb-reply.so.1)
	@$(call install_link, xcb-util, libxcb-reply.so.1.0.0, /usr/lib/libxcb-reply.so)
	
	@$(call install_copy, xcb-util, 0, 0, 0644, - , /usr/lib/libxcb-image.so.0.0.0)
	@$(call install_link, xcb-util, libxcb-image.so.0.0.0, /usr/lib/libxcb-image.so.0)
	@$(call install_link, xcb-util, libxcb-image.so.0.0.0, /usr/lib/libxcb-image.so)

	@$(call install_finish, xcb-util)

	@$(call touch)


# vim: syntax=make
