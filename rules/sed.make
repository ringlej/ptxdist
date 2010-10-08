# -*-makefile-*-
#
# Copyright (C) 2007 by KOAN sas, by Marco Cavallini <m.cavallini@koansoftware.com>
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
PACKAGES-$(PTXCONF_SED) += sed

#
# Paths and names
#
SED_VERSION	:= 4.2.1
SED_MD5		:= 7d310fbd76e01a01115075c1fd3f455a
SED		:= sed-$(SED_VERSION)
SED_SUFFIX	:= tar.bz2
SED_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/sed/$(SED).$(SED_SUFFIX)
SED_SOURCE	:= $(SRCDIR)/$(SED).$(SED_SUFFIX)
SED_DIR		:= $(BUILDDIR)/$(SED)
SED_LICENSE	:= GPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SED_SOURCE):
	@$(call targetinfo)
	@$(call get, SED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SED_PATH	:= PATH=$(CROSS_PATH)
SED_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SED_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sed.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sed)
	@$(call install_fixup, sed,PRIORITY,optional)
	@$(call install_fixup, sed,SECTION,base)
	@$(call install_fixup, sed,AUTHOR,"Marco Cavallini <m.cavallini@koansoftware.com>")
	@$(call install_fixup, sed,DESCRIPTION,missing)

	@$(call install_copy, sed, 0, 0, 0755, -, /usr/bin/sed)

	@$(call install_finish, sed)

	@$(call touch)

# vim: syntax=make
