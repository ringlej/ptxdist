# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_UTIL_MACROS) += host-xorg-util-macros

#
# Paths and names
#
HOST_XORG_UTIL_MACROS_VERSION	:= 1.4.1
HOST_XORG_UTIL_MACROS		:= util-macros-$(HOST_XORG_UTIL_MACROS_VERSION)
HOST_XORG_UTIL_MACROS_SUFFIX	:= tar.bz2
HOST_XORG_UTIL_MACROS_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/util/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX)
HOST_XORG_UTIL_MACROS_SOURCE	:= $(SRCDIR)/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX)
HOST_XORG_UTIL_MACROS_DIR	:= $(HOST_BUILDDIR)/$(HOST_XORG_UTIL_MACROS)

ifdef PTXCONF_HOST_XORG_UTIL_MACROS
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-xorg-util-macros.install.post
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_XORG_UTIL_MACROS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_XORG_UTIL_MACROS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-util-macros.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_XORG_UTIL_MACROS_DIR))
	@$(call extract, HOST_XORG_UTIL_MACROS, $(HOST_BUILDDIR))
	@$(call patchin, HOST_XORG_UTIL_MACROS, $(HOST_XORG_UTIL_MACROS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_UTIL_MACROS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_UTIL_MACROS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_UTIL_MACROS_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-util-macros.install:
	@$(call targetinfo)
	@$(call install, HOST_XORG_UTIL_MACROS,,h)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-util-macros_clean:
	rm -rf $(STATEDIR)/host-xorg-util-macros.*
	rm -rf $(HOST_XORG_UTIL_MACROS_DIR)

# vim: syntax=make
