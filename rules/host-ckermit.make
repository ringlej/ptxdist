# -*-makefile-*-
#
# Copyright (C) 2008 by Wolfram Sang
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CKERMIT) += host-ckermit

#
# Paths and names
#
HOST_CKERMIT_DIR		= $(HOST_BUILDDIR)/$(CKERMIT)
HOST_CKERMIT_STRIP_LEVEL	:= 0
HOST_CKERMIT_MAKE_OPT		:= linux
HOST_CKERMIT_INSTALL_OPT	:= install prefix=

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CKERMIT_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.install:
	@$(call targetinfo)
	@$(call install, HOST_CKERMIT)
	@ln -sf kermit $(HOST_CKERMIT_PKGDIR)/bin/ckermit
	@install -m755  $(HOST_CKERMIT_DIR)/wart $(HOST_CKERMIT_PKGDIR)/bin/
	@$(call touch)

# vim: syntax=make
