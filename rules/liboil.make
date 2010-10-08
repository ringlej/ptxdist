# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOIL) += liboil

#
# Paths and names
#
LIBOIL_VERSION	:= 0.3.16
LIBOIL_MD5	:= febb1d9f9bc4c440fcf622dc90f8b6b7
LIBOIL		:= liboil-$(LIBOIL_VERSION)
LIBOIL_SUFFIX	:= tar.gz
LIBOIL_URL	:= http://liboil.freedesktop.org/download/$(LIBOIL).$(LIBOIL_SUFFIX)
LIBOIL_SOURCE	:= $(SRCDIR)/$(LIBOIL).$(LIBOIL_SUFFIX)
LIBOIL_DIR	:= $(BUILDDIR)/$(LIBOIL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBOIL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBOIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBOIL_PATH	:= PATH=$(CROSS_PATH)
LIBOIL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBOIL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liboil.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liboil)
	@$(call install_fixup, liboil,PRIORITY,optional)
	@$(call install_fixup, liboil,SECTION,base)
	@$(call install_fixup, liboil,AUTHOR,"Guillaume GOURAT <guillaume.gourat@nexvision.fr>")
	@$(call install_fixup, liboil,DESCRIPTION,missing)

	@$(call install_lib, liboil, 0, 0, 0644, liboil-0.3)

	@$(call install_finish, liboil)

	@$(call touch)

# vim: syntax=make
