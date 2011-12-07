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
PACKAGES-$(PTXCONF_CAIROMM) += cairomm

#
# Paths and names
#
CAIROMM_VERSION	:= 1.10.0
CAIROMM_MD5	:= 9c63fb1c04c8ecd3c5e6473075b8c39f
CAIROMM		:= cairomm-$(CAIROMM_VERSION)
CAIROMM_SUFFIX	:= tar.gz
CAIROMM_URL	:= http://cairographics.org/releases/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_SOURCE	:= $(SRCDIR)/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_DIR	:= $(BUILDDIR)/$(CAIROMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CAIROMM_SOURCE):
	@$(call targetinfo)
	@$(call get, CAIROMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CAIROMM_PATH	:= PATH=$(CROSS_PATH)
CAIROMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIROMM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-documentation \
	--disable-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cairomm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cairomm)
	@$(call install_fixup, cairomm,PRIORITY,optional)
	@$(call install_fixup, cairomm,SECTION,base)
	@$(call install_fixup, cairomm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, cairomm,DESCRIPTION,missing)

	@$(call install_lib, cairomm, 0, 0, 0644, libcairomm-1.0)

	@$(call install_finish, cairomm)

	@$(call touch)

# vim: syntax=make
