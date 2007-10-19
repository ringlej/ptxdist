# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PIXMAN) += pixman

#
# Paths and names
#
PIXMAN_VERSION	:= 0.9.5
PIXMAN		:= pixman-$(PIXMAN_VERSION)
PIXMAN_SUFFIX		:= tar.bz2
PIXMAN_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(PIXMAN).$(PIXMAN_SUFFIX)
PIXMAN_SOURCE		:= $(SRCDIR)/$(PIXMAN).$(PIXMAN_SUFFIX)
PIXMAN_DIR		:= $(BUILDDIR)/$(PIXMAN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pixman_get: $(STATEDIR)/pixman.get

$(STATEDIR)/pixman.get: $(pixman_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PIXMAN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PIXMAN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pixman_extract: $(STATEDIR)/pixman.extract

$(STATEDIR)/pixman.extract: $(pixman_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PIXMAN_DIR))
	@$(call extract, PIXMAN)
	@$(call patchin, PIXMAN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pixman_prepare: $(STATEDIR)/pixman.prepare

PIXMAN_PATH	:= PATH=$(CROSS_PATH)
PIXMAN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PIXMAN_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pixman.prepare: $(pixman_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PIXMAN_DIR)/config.cache)
	cd $(PIXMAN_DIR) && \
		$(PIXMAN_PATH) $(PIXMAN_ENV) \
		./configure $(PIXMAN_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pixman_compile: $(STATEDIR)/pixman.compile

$(STATEDIR)/pixman.compile: $(pixman_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PIXMAN_DIR) && $(PIXMAN_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pixman_install: $(STATEDIR)/pixman.install

$(STATEDIR)/pixman.install: $(pixman_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PIXMAN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pixman_targetinstall: $(STATEDIR)/pixman.targetinstall

$(STATEDIR)/pixman.targetinstall: $(pixman_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pixman)
	@$(call install_fixup, pixman,PACKAGE,pixman)
	@$(call install_fixup, pixman,PRIORITY,optional)
	@$(call install_fixup, pixman,VERSION,$(PIXMAN_VERSION))
	@$(call install_fixup, pixman,SECTION,base)
	@$(call install_fixup, pixman,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, pixman,DEPENDS,)
	@$(call install_fixup, pixman,DESCRIPTION,missing)

	@$(call install_copy, pixman, 0, 0, 0644, $(PIXMAN_DIR)/pixman/.libs/libpixman-1.so.0.9.5, /usr/lib/libpixman-1.so.0.9.5)
	@$(call install_link, pixman, libpixman-1.so.0.9.5, /usr/lib/libpixman-1.so.0)
	@$(call install_link, pixman, libpixman-1.so.0.9.5, /usr/lib/libpixman-1.so)

	@$(call install_finish, pixman)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pixman_clean:
	rm -rf $(STATEDIR)/pixman.*
	rm -rf $(IMAGEDIR)/pixman_*
	rm -rf $(PIXMAN_DIR)

# vim: syntax=make
