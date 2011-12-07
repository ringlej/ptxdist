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
PACKAGES-$(PTXCONF_GLIBMM) += glibmm

#
# Paths and names
#
GLIBMM_VERSION	:= 2.30.1
GLIBMM_MD5	:= 9b333de989287c563334faa88a11fc21
GLIBMM		:= glibmm-$(GLIBMM_VERSION)
GLIBMM_SUFFIX	:= tar.bz2
GLIBMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glibmm/2.30/$(GLIBMM).$(GLIBMM_SUFFIX)
GLIBMM_SOURCE	:= $(SRCDIR)/$(GLIBMM).$(GLIBMM_SUFFIX)
GLIBMM_DIR	:= $(BUILDDIR)/$(GLIBMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GLIBMM_SOURCE):
	@$(call targetinfo)
	@$(call get, GLIBMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIBMM_PATH	:= PATH=$(CROSS_PATH)
GLIBMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GLIBMM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-documentation

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glibmm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glibmm)
	@$(call install_fixup, glibmm,PRIORITY,optional)
	@$(call install_fixup, glibmm,SECTION,base)
	@$(call install_fixup, glibmm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glibmm,DESCRIPTION,missing)

	@$(call install_lib, glibmm, 0, 0, 0644, libglibmm-2.4)
	@$(call install_lib, glibmm, 0, 0, 0644, libgiomm-2.4)

	@$(call install_finish, glibmm)

	@$(call touch)

# vim: syntax=make
