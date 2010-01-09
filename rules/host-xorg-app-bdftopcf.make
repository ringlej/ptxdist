# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_BDFTOPCF) += host-xorg-app-bdftopcf

#
# Paths and names
#
HOST_XORG_APP_BDFTOPCF_VERSION	:= 1.0.2
HOST_XORG_APP_BDFTOPCF		:= bdftopcf-$(HOST_XORG_APP_BDFTOPCF_VERSION)
HOST_XORG_APP_BDFTOPCF_SUFFIX	:= tar.bz2
HOST_XORG_APP_BDFTOPCF_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(HOST_XORG_APP_BDFTOPCF).$(HOST_XORG_APP_BDFTOPCF_SUFFIX)
HOST_XORG_APP_BDFTOPCF_SOURCE	:= $(SRCDIR)/$(HOST_XORG_APP_BDFTOPCF).$(HOST_XORG_APP_BDFTOPCF_SUFFIX)
HOST_XORG_APP_BDFTOPCF_DIR	:= $(HOST_BUILDDIR)/$(HOST_XORG_APP_BDFTOPCF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_XORG_APP_BDFTOPCF_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_XORG_APP_BDFTOPCF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-app-bdftopcf.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_XORG_APP_BDFTOPCF_DIR))
	@$(call extract, HOST_XORG_APP_BDFTOPCF, $(HOST_BUILDDIR))
	@$(call patchin, HOST_XORG_APP_BDFTOPCF, $(HOST_XORG_APP_BDFTOPCF_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_APP_BDFTOPCF_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_APP_BDFTOPCF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_BDFTOPCF_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_clean:
	rm -rf $(STATEDIR)/host-xorg-app-bdftopcf.*
	rm -rf $(HOST_XORG_APP_BDFTOPCF_DIR)

# vim: syntax=make
