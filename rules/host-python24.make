# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON24) += host-python24

#
# Paths and names
#
HOST_PYTHON24		= $(PYTHON24)
HOST_PYTHON24_DIR	= $(HOST_BUILDDIR)/$(HOST_PYTHON24)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python24.get: $(STATEDIR)/python24.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python24.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_PYTHON24_DIR))
	@$(call extract, PYTHON24, $(HOST_BUILDDIR))
	@$(call patchin, PYTHON24, $(HOST_PYTHON24_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON24_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON24_ENV 	:= $(HOST_ENV)
HOST_PYTHON24_COMPILE_ENV	:= DESTDIR=/

#
# autoconf
#
HOST_PYTHON24_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python24.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON24,,h)

	sed -i -e "s/^\(LDFLAGS=\).*$$/\1/" "$(PTXCONF_SYSROOT_HOST)/lib/python2.4/config/Makefile"

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-python24_clean:
	rm -rf $(STATEDIR)/host-python24.*
	rm -rf $(HOST_PYTHON24_DIR)

# vim: syntax=make
