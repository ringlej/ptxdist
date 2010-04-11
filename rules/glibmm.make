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
GLIBMM_VERSION	:= 2.22.1
GLIBMM		:= glibmm-$(GLIBMM_VERSION)
GLIBMM_SUFFIX	:= tar.bz2
GLIBMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glibmm/2.22/$(GLIBMM).$(GLIBMM_SUFFIX)
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
	@$(call install_fixup, glibmm,PACKAGE,glibmm)
	@$(call install_fixup, glibmm,PRIORITY,optional)
	@$(call install_fixup, glibmm,VERSION,$(GLIBMM_VERSION))
	@$(call install_fixup, glibmm,SECTION,base)
	@$(call install_fixup, glibmm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glibmm,DEPENDS,)
	@$(call install_fixup, glibmm,DESCRIPTION,missing)

	@$(call install_copy, glibmm, 0, 0, 0644, -, \
		/usr/lib/libglibmm-2.4.so.1.2.0)
	@$(call install_link, glibmm, \
		libglibmm-2.4.so.1.2.0, /usr/lib/libglibmm-2.4.so.1)
	@$(call install_link, glibmm, \
		libglibmm-2.4.so.1.2.0, /usr/lib/libglibmm-2.4.so)

	@$(call install_copy, glibmm, 0, 0, 0644, -, \
		/usr/lib/libgiomm-2.4.so.1.2.0)
	@$(call install_link, glibmm, \
		libgiomm-2.4.so.1.2.0, /usr/lib/libgiomm-2.4.so.1)
	@$(call install_link, glibmm, \
		libgiomm-2.4.so.1.2.0, /usr/lib/libgiomm-2.4.so)

	@$(call install_finish, glibmm)

	@$(call touch)

# vim: syntax=make
