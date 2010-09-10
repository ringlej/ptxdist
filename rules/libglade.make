# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGLADE) += libglade

#
# Paths and names
#
LIBGLADE_VERSION	:= 2.6.2
LIBGLADE		:= libglade-$(LIBGLADE_VERSION)
LIBGLADE_SUFFIX		:= tar.bz2
LIBGLADE_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libglade/2.6/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_SOURCE		:= $(SRCDIR)/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_DIR		:= $(BUILDDIR)/$(LIBGLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGLADE_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGLADE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGLADE_PATH	:= PATH=$(CROSS_PATH)
LIBGLADE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGLADE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libglade.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libglade)
	@$(call install_fixup, libglade,PRIORITY,optional)
	@$(call install_fixup, libglade,SECTION,base)
	@$(call install_fixup, libglade,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libglade,DESCRIPTION,missing)

	@$(call install_lib, libglade, 0, 0, 0644, libglade-2.0)

	@$(call install_finish, libglade)

	@$(call touch)

# vim: syntax=make
