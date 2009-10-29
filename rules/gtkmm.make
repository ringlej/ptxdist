# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTKMM) += gtkmm

#
# Paths and names
#
GTKMM_VERSION	:= 2.18.2
GTKMM		:= gtkmm-$(GTKMM_VERSION)
GTKMM_SUFFIX	:= tar.bz2
GTKMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/gtkmm/2.18/$(GTKMM).$(GTKMM_SUFFIX)
GTKMM_SOURCE	:= $(SRCDIR)/$(GTKMM).$(GTKMM_SUFFIX)
GTKMM_DIR	:= $(BUILDDIR)/$(GTKMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GTKMM_SOURCE):
	@$(call targetinfo)
	@$(call get, GTKMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GTKMM_PATH	:= PATH=$(CROSS_PATH)
GTKMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GTKMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtkmm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtkmm)
	@$(call install_fixup, gtkmm,PACKAGE,gtkmm)
	@$(call install_fixup, gtkmm,PRIORITY,optional)
	@$(call install_fixup, gtkmm,VERSION,$(GTKMM_VERSION))
	@$(call install_fixup, gtkmm,SECTION,base)
	@$(call install_fixup, gtkmm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gtkmm,DEPENDS,)
	@$(call install_fixup, gtkmm,DESCRIPTION,missing)

	@$(call install_copy, gtkmm, 0, 0, 0644, \
		$(GTKMM_DIR)/gtk/gtkmm/.libs/libgtkmm-2.4.so.1.1.0, \
		/usr/lib/libgtkmm-2.4.so.1.1.0)

	@$(call install_link, gtkmm, \
		libgtkmm-2.4.so.1.1.0, /usr/lib/libgtkmm-2.4.so.1)

	@$(call install_link, gtkmm, \
		libgtkmm-2.4.so.1.1.0, /usr/lib/libgtkmm-2.4.so)

	@$(call install_copy, gtkmm, 0, 0, 0644, \
		$(GTKMM_DIR)/gdk/gdkmm/.libs/libgdkmm-2.4.so.1.1.0, \
		/usr/lib/libgdkmm-2.4.so.1.1.0)

	@$(call install_link, gtkmm, \
		libgdkmm-2.4.so.1.1.0, /usr/lib/libgdkmm-2.4.so.1)

	@$(call install_link, gtkmm, \
		libgdkmm-2.4.so.1.1.0, /usr/lib/libgdkmm-2.4.so)

	@$(call install_copy, gtkmm, 0, 0, 0644, \
		$(GTKMM_DIR)/atk/atkmm/.libs/libatkmm-1.6.so.1.1.0, \
		/usr/lib/libatkmm-1.6.so.1.1.0)

	@$(call install_link, gtkmm, \
		libatkmm-1.6.so.1.1.0, /usr/lib/libatkmm-1.6.so.1)

	@$(call install_link, gtkmm, \
		libatkmm-1.6.so.1.1.0, /usr/lib/libatkmm-1.6.so)

	@$(call install_link, gtkmm, \
		libpangomm-1.4.so.1.1.0, /usr/lib/libpangomm-1.4.so.1)

	@$(call install_link, gtkmm, \
		libpangomm-1.4.so.1.1.0, /usr/lib/libpangomm-1.4.so)

	@$(call install_finish, gtkmm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtkmm_clean:
	rm -rf $(STATEDIR)/gtkmm.*
	rm -rf $(PKGDIR)/gtkmm_*
	rm -rf $(GTKMM_DIR)

# vim: syntax=make
