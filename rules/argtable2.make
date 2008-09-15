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
PACKAGES-$(PTXCONF_ARGTABLE2) += argtable2

#
# Paths and names
#
ARGTABLE2_VERSION	:= 9
ARGTABLE2		:= argtable2-$(ARGTABLE2_VERSION)
ARGTABLE2_SUFFIX	:= tar.gz
ARGTABLE2_URL		:= $(PTXCONF_SETUP_SFMIRROR)/argtable/$(ARGTABLE2).$(ARGTABLE2_SUFFIX)
ARGTABLE2_SOURCE	:= $(SRCDIR)/$(ARGTABLE2).$(ARGTABLE2_SUFFIX)
ARGTABLE2_DIR		:= $(BUILDDIR)/$(ARGTABLE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

argtable2_get: $(STATEDIR)/argtable2.get

$(STATEDIR)/argtable2.get: $(argtable2_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ARGTABLE2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ARGTABLE2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

argtable2_extract: $(STATEDIR)/argtable2.extract

$(STATEDIR)/argtable2.extract: $(argtable2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ARGTABLE2_DIR))
	@$(call extract, ARGTABLE2)
	@$(call patchin, ARGTABLE2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

argtable2_prepare: $(STATEDIR)/argtable2.prepare

ARGTABLE2_PATH	:= PATH=$(CROSS_PATH)
ARGTABLE2_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ARGTABLE2_AUTOCONF := $(CROSS_AUTOCONF_USR) --disable-debug

$(STATEDIR)/argtable2.prepare: $(argtable2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ARGTABLE2_DIR)/config.cache)
	cd $(ARGTABLE2_DIR) && \
		$(ARGTABLE2_PATH) $(ARGTABLE2_ENV) \
		./configure $(ARGTABLE2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

argtable2_compile: $(STATEDIR)/argtable2.compile

$(STATEDIR)/argtable2.compile: $(argtable2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ARGTABLE2_DIR) && $(ARGTABLE2_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

argtable2_install: $(STATEDIR)/argtable2.install

$(STATEDIR)/argtable2.install: $(argtable2_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ARGTABLE2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

argtable2_targetinstall: $(STATEDIR)/argtable2.targetinstall

$(STATEDIR)/argtable2.targetinstall: $(argtable2_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, argtable2)
	@$(call install_fixup, argtable2,PACKAGE,argtable2)
	@$(call install_fixup, argtable2,PRIORITY,optional)
	@$(call install_fixup, argtable2,VERSION,$(ARGTABLE2_VERSION))
	@$(call install_fixup, argtable2,SECTION,base)
	@$(call install_fixup, argtable2,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, argtable2,DEPENDS,)
	@$(call install_fixup, argtable2,DESCRIPTION,missing)

	@$(call install_copy, argtable2, 0, 0, 0644, \
		$(ARGTABLE2_DIR)/src/.libs/libargtable2.so.0.1.4, \
		/usr/lib/libargtable2.so.0.1.2)
	@$(call install_link, argtable2, libargtable2.so.0.1.4, /usr/lib/libargtable2.so.0)
	@$(call install_link, argtable2, libargtable2.so.0.1.4, /usr/lib/libargtable2.so)

	@$(call install_finish, argtable2)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

argtable2_clean:
	rm -rf $(STATEDIR)/argtable2.*
	rm -rf $(PKGDIR)/argtable2_*
	rm -rf $(ARGTABLE2_DIR)

# vim: syntax=make
