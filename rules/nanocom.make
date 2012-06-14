# -*-makefile-*-
#
# Copyright (C) 2007 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NANOCOM) += nanocom

#
# Paths and names
#
NANOCOM_VERSION		:= 1.0
NANOCOM_MD5		:= 6dd9cc4f4a2191952ee8b13da877dec5
NANOCOM			:= nanocom-$(NANOCOM_VERSION)
NANOCOM_SUFFIX		:= tar.bz2
NANOCOM_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(NANOCOM).$(NANOCOM_SUFFIX)
NANOCOM_SOURCE		:= $(SRCDIR)/$(NANOCOM).$(NANOCOM_SUFFIX)
NANOCOM_DIR		:= $(BUILDDIR)/$(NANOCOM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NANOCOM_PATH	:= PATH=$(CROSS_PATH)
NANOCOM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
NANOCOM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/nanocom.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/nanocom.compile:
	@$(call targetinfo)
	@cd $(NANOCOM_DIR) && $(NANOCOM_PATH) $(NANOCOM_ENV) $(MAKE) $(PARALLELMFLAGS) $(CROSS_ENV_CC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nanocom.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nanocom.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nanocom)
	@$(call install_fixup, nanocom,PRIORITY,optional)
	@$(call install_fixup, nanocom,SECTION,base)
	@$(call install_fixup, nanocom,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, nanocom,DESCRIPTION,missing)

	@$(call install_copy, nanocom, 0, 0, 0755, $(NANOCOM_DIR)/nanocom, /bin/nanocom)

	@$(call install_finish, nanocom)

	@$(call touch)

# vim: syntax=make
