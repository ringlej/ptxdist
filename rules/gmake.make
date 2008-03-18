# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GMAKE) += gmake

#
# Paths and names
#
GMAKE_VERSION	:= 3.81
GMAKE		:= make-$(GMAKE_VERSION)
GMAKE_SUFFIX	:= tar.bz2
GMAKE_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/make/$(GMAKE).$(GMAKE_SUFFIX)
GMAKE_SOURCE	:= $(SRCDIR)/$(GMAKE).$(GMAKE_SUFFIX)
GMAKE_DIR	:= $(BUILDDIR)/$(GMAKE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gmake_get: $(STATEDIR)/gmake.get

$(STATEDIR)/gmake.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GMAKE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GMAKE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gmake_extract: $(STATEDIR)/gmake.extract

$(STATEDIR)/gmake.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(GMAKE_DIR))
	@$(call extract, GMAKE)
	@$(call patchin, GMAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gmake_prepare: $(STATEDIR)/gmake.prepare

GMAKE_PATH	:= PATH=$(CROSS_PATH)
GMAKE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GMAKE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--without-libintl-prefix

$(STATEDIR)/gmake.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(GMAKE_DIR)/config.cache)
	cd $(GMAKE_DIR) && \
		$(GMAKE_PATH) $(GMAKE_ENV) \
		./configure $(GMAKE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gmake_compile: $(STATEDIR)/gmake.compile

$(STATEDIR)/gmake.compile:
	@$(call targetinfo, $@)
	cd $(GMAKE_DIR) && $(GMAKE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gmake_install: $(STATEDIR)/gmake.install

$(STATEDIR)/gmake.install:
	@$(call targetinfo, $@)
	@$(call install, GMAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gmake_targetinstall: $(STATEDIR)/gmake.targetinstall

$(STATEDIR)/gmake.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, gmake)
	@$(call install_fixup, gmake,PACKAGE,gmake)
	@$(call install_fixup, gmake,PRIORITY,optional)
	@$(call install_fixup, gmake,VERSION,$(GMAKE_VERSION))
	@$(call install_fixup, gmake,SECTION,base)
	@$(call install_fixup, gmake,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gmake,DEPENDS,)
	@$(call install_fixup, gmake,DESCRIPTION,missing)

	@$(call install_copy, gmake, 0, 0, 0755, $(GMAKE_DIR)/make, /usr/bin/make)

	@$(call install_finish, gmake)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gmake_clean:
	rm -rf $(STATEDIR)/gmake.*
	rm -rf $(IMAGEDIR)/gmake_*
	rm -rf $(GMAKE_DIR)

# vim: syntax=make
