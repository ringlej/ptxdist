#
# Copyright (C) 2007 by Juergen Beisert
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PNPUTILS) += pnputils

#
# Paths and names
#
PNPUTILS_VERSION	:= 0.1
PNPUTILS_MD5		:= 7fd1e18cc8b9eddcccb355654291fac3
PNPUTILS		:= pnputils-$(PNPUTILS_VERSION)
PNPUTILS_SUFFIX		:= tar.bz2
PNPUTILS_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(PNPUTILS).$(PNPUTILS_SUFFIX)
PNPUTILS_SOURCE		:= $(SRCDIR)/$(PNPUTILS).$(PNPUTILS_SUFFIX)
PNPUTILS_DIR		:= $(BUILDDIR)/$(PNPUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PNPUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, PNPUTILS)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

PNPUTILS_PATH		:= PATH=$(CROSS_PATH)
PNPUTILS_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pnputils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pnputils)
	@$(call install_fixup, pnputils,PRIORITY,optional)
	@$(call install_fixup, pnputils,SECTION,base)
	@$(call install_fixup, pnputils,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, pnputils,DESCRIPTION,missing)

ifdef PTXCONF_PNPUTILS_SETPNP
	@$(call install_copy, pnputils, 0, 0, 0755, -, /sbin/setpnp)
endif
ifdef PTXCONF_PNPUTILS_LSPNP
	@$(call install_copy, pnputils, 0, 0, 0755, -, /sbin/lspnp)
endif

	@$(call install_finish, pnputils)

	@$(call touch)

# vim: syntax=make
