# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2006 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZLIB) += zlib

#
# Paths and names
#
ZLIB_VERSION	:= 1.2.3-ptx1
ZLIB		:= zlib-$(ZLIB_VERSION)
ZLIB_SUFFIX	:= tar.bz2
ZLIB_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(ZLIB).$(ZLIB_SUFFIX)
ZLIB_SOURCE	:= $(SRCDIR)/$(ZLIB).$(ZLIB_SUFFIX)
ZLIB_DIR	:= $(BUILDDIR)/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

zlib_get: $(STATEDIR)/zlib.get

$(STATEDIR)/zlib.get: $(zlib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ZLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ZLIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zlib_extract: $(STATEDIR)/zlib.extract

$(STATEDIR)/zlib.extract: $(zlib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ZLIB_DIR))
	@$(call extract, ZLIB)
	@$(call patchin, ZLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zlib_prepare: $(STATEDIR)/zlib.prepare

ZLIB_PATH	:= PATH=$(CROSS_PATH)
ZLIB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ZLIB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/zlib.prepare: $(zlib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ZLIB_DIR)/config.cache)
	cd $(ZLIB_DIR) && \
		$(ZLIB_PATH) $(ZLIB_ENV) \
		./configure $(ZLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zlib_compile: $(STATEDIR)/zlib.compile

$(STATEDIR)/zlib.compile: $(zlib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ZLIB_DIR) && $(ZLIB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zlib_install: $(STATEDIR)/zlib.install

$(STATEDIR)/zlib.install: $(zlib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ZLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zlib_targetinstall: $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/zlib.targetinstall: $(zlib_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, zlib)
	@$(call install_fixup, zlib,PACKAGE,zlib)
	@$(call install_fixup, zlib,PRIORITY,optional)
	@$(call install_fixup, zlib,VERSION,$(ZLIB_VERSION))
	@$(call install_fixup, zlib,SECTION,base)
	@$(call install_fixup, zlib,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, zlib,DEPENDS,)
	@$(call install_fixup, zlib,DESCRIPTION,missing)

	@$(call install_copy, zlib, 0, 0, 0644, $(ZLIB_DIR)/.libs/libz.so.0.0.0, /usr/lib/libz.so.0.0.0)
	@$(call install_link, zlib, libz.so.0.0.0, /usr/lib/libz.so.0)
	@$(call install_link, zlib, libz.so.0.0.0, /usr/lib/libz.so)

	@$(call install_finish, zlib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zlib_clean:
	rm -rf $(STATEDIR)/zlib.*
	rm -rf $(IMAGEDIR)/zlib_*
	rm -rf $(ZLIB_DIR)

# vim: syntax=make
