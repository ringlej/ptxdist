# -*-makefile-*-
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
HOST_PACKAGES-$(PTXCONF_HOST_GENPART) += host-genpart

#
# Paths and names
#
HOST_GENPART_VERSION	:= 1.0.2
HOST_GENPART		:= genpart-$(HOST_GENPART_VERSION)
HOST_GENPART_SUFFIX	:= tar.bz2
HOST_GENPART_URL	:= http://www.pengutronix.de/software/genpart/download/$(HOST_GENPART).$(HOST_GENPART_SUFFIX)
HOST_GENPART_SOURCE	:= $(SRCDIR)/$(HOST_GENPART).$(HOST_GENPART_SUFFIX)
HOST_GENPART_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENPART)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_GENPART_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_GENPART)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-genpart.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GENPART_DIR))
	@$(call extract, HOST_GENPART, $(HOST_BUILDDIR))
	@$(call patchin, HOST_GENPART, $(HOST_GENPART_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GENPART_PATH	:= PATH=$(HOST_PATH)
HOST_GENPART_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GENPART_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
