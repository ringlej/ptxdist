# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLIB) += host-glib

#
# Paths and names
#
HOST_GLIB_DIR	= $(HOST_BUILDDIR)/$(GLIB)

ifdef PTXCONF_HOST_GLIB
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-glib.install
endif


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib.get: $(STATEDIR)/glib.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GLIB_DIR))
	@$(call extract, GLIB, $(HOST_BUILDDIR))
	@$(call patchin, GLIB, $(HOST_GLIB_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLIB_PATH	:= PATH=$(HOST_PATH)
HOST_GLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
# 'iconv' feature: configure tests for this feature in the glibc first. If not
#                  found it checks for iconv library in the next step. On most
#                  hosts 'iconv' should be present in the regular host glibc.
#
HOST_GLIB_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--with-libiconv=gnu

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glib_clean:
	rm -rf $(STATEDIR)/host-glib.*
	rm -rf $(HOST_GLIB_DIR)

# vim: syntax=make
