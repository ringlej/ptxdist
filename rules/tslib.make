# -*-makefile-*-
# $Id: template 3079 2005-09-02 18:09:51Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TSLIB) += tslib

#
# Paths and names
#
TSLIB_VERSION	= 0.0.2
TSLIB		= tslib-$(TSLIB_VERSION)
TSLIB_SUFFIX		= tar.bz2
TSLIB_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_SOURCE		= $(SRCDIR)/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_DIR		= $(BUILDDIR)/$(TSLIB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tslib_get: $(STATEDIR)/tslib.get

$(STATEDIR)/tslib.get: $(tslib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TSLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TSLIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tslib_extract: $(STATEDIR)/tslib.extract

$(STATEDIR)/tslib.extract: $(tslib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TSLIB_DIR))
	@$(call extract, TSLIB)
	@$(call patchin, TSLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tslib_prepare: $(STATEDIR)/tslib.prepare

TSLIB_PATH	=  PATH=$(CROSS_PATH)
TSLIB_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
TSLIB_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/tslib.prepare: $(tslib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TSLIB_DIR)/config.cache)
	cd $(TSLIB_DIR) && \
		$(TSLIB_PATH) $(TSLIB_ENV) \
		./configure $(TSLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tslib_compile: $(STATEDIR)/tslib.compile

$(STATEDIR)/tslib.compile: $(tslib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TSLIB_DIR) && $(TSLIB_ENV) $(TSLIB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tslib_install: $(STATEDIR)/tslib.install

$(STATEDIR)/tslib.install: $(tslib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, TSLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tslib_targetinstall: $(STATEDIR)/tslib.targetinstall

$(STATEDIR)/tslib.targetinstall: $(tslib_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, tslib)
	@$(call install_fixup, tslib,PACKAGE,tslib)
	@$(call install_fixup, tslib,PRIORITY,optional)
	@$(call install_fixup, tslib,VERSION,$(TSLIB_VERSION))
	@$(call install_fixup, tslib,SECTION,base)
	@$(call install_fixup, tslib,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, tslib,DEPENDS,)
	@$(call install_fixup, tslib,DESCRIPTION,missing)

	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/src/.libs/libts-0.0.so.0.1.1, /usr/lib/libts-0.0.so.0.1.1)
	@$(call install_link, tslib, libts-0.0.so.0.1.1, /usr/lib/libts.so)
	@$(call install_link, tslib, libts-0.0.so.0.1.1, /usr/lib/libts-0.0.so.0)

ifdef PTXCONF_TSLIB_TS_CALIBRATE
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/tests/.libs/ts_calibrate, /usr/bin/ts_calibrate)
endif
ifdef PTXCONF_TSLIB_TS_TEST
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/tests/.libs/ts_test, /usr/bin/ts_test)
endif

	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/input.so, /usr/lib/ts/input.so)
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/pthres.so, /usr/lib/ts/pthres.so)
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/variance.so, /usr/lib/ts/variance.so)
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/dejitter.so, /usr/lib/ts/dejitter.so)
	@$(call install_copy, tslib, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/linear.so, /usr/lib/ts/linear.so)

	@$(call install_finish, tslib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tslib_clean:
	rm -rf $(STATEDIR)/tslib.*
	rm -rf $(IMAGEDIR)/tslib_*
	rm -rf $(TSLIB_DIR)

# vim: syntax=make
