# -*-makefile-*-
# $Id$
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
CROSS_LIBTOOL_VERSION	:= 1.5.16
CROSS_LIBTOOL		:= libtool-$(CROSS_LIBTOOL_VERSION)
CROSS_LIBTOOL_SUFFIX	:= tar.gz
CROSS_LIBTOOL_URL	:= ftp://ftp.gnu.org/gnu/libtool/$(CROSS_LIBTOOL).$(CROSS_LIBTOOL_SUFFIX)
CROSS_LIBTOOL_SOURCE	:= $(SRCDIR)/$(CROSS_LIBTOOL).$(CROSS_LIBTOOL_SUFFIX)
CROSS_LIBTOOL_DIR	:= $(CROSS_BUILDDIR)/$(CROSS_LIBTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CROSS_LIBTOOL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CROSS_LIBTOOL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_LIBTOOL_DIR))
	@$(call extract, CROSS_LIBTOOL, $(CROSS_BUILDDIR))
	@$(call patchin, CROSS_LIBTOOL, $(CROSS_LIBTOOL_DIR))
	@$(call touch, $@)

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

$(STATEDIR)/cross-libtool.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_LIBTOOL_DIR)/config.cache)
	cd $(CROSS_LIBTOOL_DIR) && \
		$(CROSS_LIBTOOL_PATH) $(CROSS_LIBTOOL_ENV) \
		./configure $(CROSS_LIBTOOL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.compile:
	@$(call targetinfo, $@)
	cd $(CROSS_LIBTOOL_DIR) && $(CROSS_LIBTOOL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-libtool.install:
	@$(call targetinfo, $@)
	@$(call install, CROSS_LIBTOOL,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-libtool_clean:
	rm -rf $(STATEDIR)/cross-libtool.*
	rm -rf $(CROSS_LIBTOOL_DIR)

# vim: syntax=make
