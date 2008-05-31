# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VICE) += vice

#
# Paths and names
#
VICE_VERSION	:= 1.22
VICE		:= vice-$(VICE_VERSION)
VICE_SUFFIX	:= tar.gz
VICE_URL	:= http://www.viceteam.org/online/$(VICE).$(VICE_SUFFIX)
VICE_SOURCE	:= $(SRCDIR)/$(VICE).$(VICE_SUFFIX)
VICE_DIR	:= $(BUILDDIR)/$(VICE)
# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

vice_get: $(STATEDIR)/vice.get

$(STATEDIR)/vice.get: $(vice_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(VICE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, VICE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

vice_extract: $(STATEDIR)/vice.extract

$(STATEDIR)/vice.extract: $(vice_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(VICE_DIR))
	@$(call extract, VICE)
	@$(call patchin, VICE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

vice_prepare: $(STATEDIR)/vice.prepare

VICE_PATH	:= PATH=$(CROSS_PATH)
VICE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
VICE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	\
	--disable-ipv6 \
	\
	--without-xaw3d \
	--with-readline \
	\
	--without-arts \
	--without-esd \
	--with-alsa \
	--without-oss \
	--without-resid \
	--without-png \
	--without-zlib \
	--without-picasso96 \
	--without-cocoa

$(STATEDIR)/vice.prepare: $(vice_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(VICE_DIR)/config.cache)
	cd $(VICE_DIR) && \
		$(VICE_PATH) $(VICE_ENV) \
		./configure $(VICE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

vice_compile: $(STATEDIR)/vice.compile

$(STATEDIR)/vice.compile: $(vice_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(VICE_DIR) && $(VICE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

vice_install: $(STATEDIR)/vice.install

$(STATEDIR)/vice.install: $(vice_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, VICE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

vice_targetinstall: $(STATEDIR)/vice.targetinstall

$(STATEDIR)/vice.targetinstall: $(vice_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, vice)
	@$(call install_fixup, vice,PACKAGE,vice)
	@$(call install_fixup, vice,PRIORITY,optional)
	@$(call install_fixup, vice,VERSION,$(VICE_VERSION))
	@$(call install_fixup, vice,SECTION,base)
	@$(call install_fixup, vice,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, vice,DEPENDS,)
	@$(call install_fixup, vice,DESCRIPTION,missing)

#	@$(call install_copy, vice, 0, 0, 0755, $(VICE_DIR)/foobar, /dev/null)

	@$(call install_finish, vice)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

vice_clean:
	rm -rf $(STATEDIR)/vice.*
	rm -rf $(IMAGEDIR)/vice_*
	rm -rf $(VICE_DIR)

# vim: syntax=make
