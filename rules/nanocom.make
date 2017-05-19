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

NANOCOM_CONF_TOOL	:= NO
NANOCOM_MAKE_OPT	:= \
	$(CROSS_ENV_CC)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nanocom.install:
	@$(call targetinfo)
	@install -v -m 0755 -D $(NANOCOM_DIR)/nanocom \
		$(NANOCOM_PKGDIR)/usr/bin/nanocom
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

	@$(call install_copy, nanocom, 0, 0, 0755, -, /usr/bin/nanocom)

	@$(call install_finish, nanocom)

	@$(call touch)

# vim: syntax=make
