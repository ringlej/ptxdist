# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by KOAN sas, by Marco Cavallini <m.cavallini@koansoftware.com>
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
SED_VERSION	:= 4.1.5
SED		:= sed-$(SED_VERSION)
SED_SUFFIX	:= tar.gz
SED_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/sed/$(SED).$(SED_SUFFIX)
SED_SOURCE	:= $(SRCDIR)/$(SED).$(SED_SUFFIX)
SED_DIR		:= $(BUILDDIR)/$(SED)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SED_SOURCE):
	@$(call targetinfo)
	@$(call get, SED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sed_prepare: $(STATEDIR)/sed.prepare

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
	@$(call install_fixup, sed,PACKAGE,sed)
	@$(call install_fixup, sed,PRIORITY,optional)
	@$(call install_fixup, sed,VERSION,$(SED_VERSION))
	@$(call install_fixup, sed,SECTION,base)
	@$(call install_fixup, sed,AUTHOR,"Marco Cavallini <m.cavallini\@koansoftware.com>")
	@$(call install_fixup, sed,DEPENDS,)
	@$(call install_fixup, sed,DESCRIPTION,missing)

	@$(call install_copy, sed, 0, 0, 0755, $(SED_DIR)/sed/sed, /usr/bin/sed)

	@$(call install_finish, sed)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sed_clean:
	rm -rf $(STATEDIR)/sed.*
	rm -rf $(PKGDIR)/sed_*
	rm -rf $(SED_DIR)

# vim: syntax=make
