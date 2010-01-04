# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSIGCPP) += libsigcpp

#
# Paths and names
#
LIBSIGCPP_VERSION	:= 2.2.3
LIBSIGCPP		:= libsigc++-$(LIBSIGCPP_VERSION)
LIBSIGCPP_SUFFIX	:= tar.bz2
LIBSIGCPP_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.2/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX)
LIBSIGCPP_SOURCE	:= $(SRCDIR)/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX)
LIBSIGCPP_DIR		:= $(BUILDDIR)/$(LIBSIGCPP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBSIGCPP_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBSIGCPP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSIGCPP_PATH	:= PATH=$(CROSS_PATH)
LIBSIGCPP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBSIGCPP_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsigcpp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsigcpp)
	@$(call install_fixup, libsigcpp,PACKAGE,libsigcpp)
	@$(call install_fixup, libsigcpp,PRIORITY,optional)
	@$(call install_fixup, libsigcpp,VERSION,$(LIBSIGCPP_VERSION))
	@$(call install_fixup, libsigcpp,SECTION,base)
	@$(call install_fixup, libsigcpp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libsigcpp,DEPENDS,)
	@$(call install_fixup, libsigcpp,DESCRIPTION,missing)

	@$(call install_copy, libsigcpp, 0, 0, 0644, -, \
		/usr/lib/libsigc-2.0.so.0.0.0)
	@$(call install_link, libsigcpp, libsigc-2.0.so.0.0.0, /usr/lib/libsigc-2.0.so.0)
	@$(call install_link, libsigcpp, libsigc-2.0.so.0.0.0, /usr/lib/libsigc-2.0.so)

	@$(call install_finish, libsigcpp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libsigcpp_clean:
	rm -rf $(STATEDIR)/libsigcpp.*
	rm -rf $(PKGDIR)/libsigcpp_*
	rm -rf $(LIBSIGCPP_DIR)

# vim: syntax=make
