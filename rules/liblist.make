# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2005 by Robert Schwebel
# 		2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLIST) += liblist

#
# Paths and names
#
LIBLIST_VERSION	:= 1.0.3
LIBLIST		:= liblist-$(LIBLIST_VERSION)
LIBLIST_SUFFIX	:= tar.gz
LIBLIST_URL	:= http://www.pengutronix.de/software/liblist/download/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_SOURCE	:= $(SRCDIR)/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_DIR	:= $(BUILDDIR)/$(LIBLIST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBLIST_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBLIST)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLIST_PATH	:= PATH=$(CROSS_PATH)
LIBLIST_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBLIST_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liblist.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liblist)
	@$(call install_fixup, liblist,PACKAGE,liblist)
	@$(call install_fixup, liblist,PRIORITY,optional)
	@$(call install_fixup, liblist,VERSION,$(LIBLIST_VERSION))
	@$(call install_fixup, liblist,SECTION,base)
	@$(call install_fixup, liblist,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, liblist,DEPENDS,)
	@$(call install_fixup, liblist,DESCRIPTION,missing)

	@$(call install_copy, liblist, 0, 0, 0644, -, \
		/usr/lib/libptxlist.so.0.0.0)
	@$(call install_link, liblist, libptxlist.so.0.0.0, \
		/usr/lib/libptxlist.so.0)
	@$(call install_link, liblist, libptxlist.so.0.0.0, \
		/usr/lib/libptxlist.so)

	@$(call install_finish, liblist)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liblist_clean:
	rm -rf $(STATEDIR)/liblist.*
	rm -rf $(PKGDIR)/liblist_*
	rm -rf $(LIBLIST_DIR)

# vim: syntax=make
