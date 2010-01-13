# -*-makefile-*-
#
# Copyright (C) 2008 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_LIBTOOL) += cross-libtool

#
# Paths and names
#
CROSS_LIBTOOL_DIR	= $(CROSS_BUILDDIR)/$(LIBLTDL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.get: $(STATEDIR)/libltdl.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.extract:
	@$(call targetinfo)
	@$(call clean, $(CROSS_LIBTOOL_DIR))
	@$(call extract, LIBLTDL, $(CROSS_BUILDDIR))
	@$(call patchin, LIBLTDL, $(CROSS_LIBTOOL_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CROSS_LIBTOOL_PATH	:= PATH=$(CROSS_PATH)
CROSS_LIBTOOL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CROSS_LIBTOOL_AUTOCONF	:= \
	$(HOST_CROSS_AUTOCONF) \
	--prefix=$(PTXCONF_SYSROOT_CROSS) \
	--host=$(PTXCONF_GNU_TARGET) \
	--build=$(GNU_HOST)

# vim: syntax=make
