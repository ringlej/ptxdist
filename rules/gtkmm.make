# -*-makefile-*-
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
GTKMM_VERSION	:= 3.2.0
GTKMM_MD5	:= 686c41d0ff584d3d10b4503df02bb3dc
GTKMM		:= gtkmm-$(GTKMM_VERSION)
GTKMM_SUFFIX	:= tar.bz2
GTKMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/gtkmm/3.2/$(GTKMM).$(GTKMM_SUFFIX)
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
GTKMM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-documentation

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtkmm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtkmm)
	@$(call install_fixup, gtkmm,PRIORITY,optional)
	@$(call install_fixup, gtkmm,SECTION,base)
	@$(call install_fixup, gtkmm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtkmm,DESCRIPTION,missing)

	@$(call install_lib, gtkmm, 0, 0, 0644, libgtkmm-3.0)
	@$(call install_lib, gtkmm, 0, 0, 0644, libgdkmm-3.0)

	@$(call install_finish, gtkmm)

	@$(call touch)

# vim: syntax=make
