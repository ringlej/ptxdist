# -*-makefile-*-
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
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
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	:= 1.28.0
ATK_MD5		:= 010a85478adc053c016a0a5c9bb52004
ATK		:= atk-$(ATK_VERSION)
ATK_SUFFIX	:= tar.bz2
ATK_URL		:= http://ftp.gnome.org/pub/gnome/sources/atk/1.28/$(ATK).$(ATK_SUFFIX)
ATK_SOURCE	:= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		:= $(BUILDDIR)/$(ATK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ATK_SOURCE):
	@$(call targetinfo)
	@$(call get, ATK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ATK_PATH	:= PATH=$(CROSS_PATH)
ATK_ENV		:= $(CROSS_ENV)

#
# autoconf
#
ATK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--disable-glibtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atk)
	@$(call install_fixup, atk,PRIORITY,optional)
	@$(call install_fixup, atk,SECTION,base)
	@$(call install_fixup, atk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, atk,DESCRIPTION,missing)

	@$(call install_lib, atk, 0, 0, 0644, libatk-1.0)

	@$(call install_finish, atk)

	@$(call touch)

# vim: syntax=make
